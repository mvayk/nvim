--// shoutout to anthropic
local enabled = vim.g.neovide

if not enabled then
    return {}
end

return {
    "stevearc/resession.nvim",
    enabled = true,
    lazy = false,
    config = function()
        local resession = require("resession")

        local dir = "dirsession"
        local session_name = "tabs"
        local state_file = vim.fn.stdpath("state") .. "/tab_roots.json"

        -- used only for files outside the declared projects below
        local markers = { ".git", "flake.nix" }

        resession.setup({
            autosave = { enabled = true, interval = 60, notify = false },
            -- the default filter only keeps listed buffers; buffers hidden because they
            -- belong to another tab (tab_hidden) must still be saved
            buf_filter = function(b)
                return (vim.bo[b].buflisted or vim.b[b].tab_hidden)
                    and vim.bo[b].buftype == ""
                    and vim.api.nvim_buf_get_name(b) ~= ""
            end,
        })

        ---------------------------------------------------------------------------
        -- path helpers
        ---------------------------------------------------------------------------
        local function norm(path)
            path = vim.fs.normalize(path)
            return vim.uv.fs_realpath(path) or path
        end

        local function norm_file(file)
            file = vim.fs.normalize(file)
            local d = vim.uv.fs_realpath(vim.fs.dirname(file))
            return d and (d .. "/" .. vim.fs.basename(file)) or file
        end

        local function in_dir(file, d)
            return vim.startswith(file, d .. "/")
        end

        local function is_uri(name)
            return name:match("^%w[%w+.-]*://") ~= nil
        end

        local home = norm(vim.env.HOME)
        local resetting = false -- true while :ProjectReset runs, pauses all routing/saving

        local scratch_dir = vim.fn.stdpath("data") .. "/scratch"
        vim.fn.mkdir(scratch_dir, "p")
        scratch_dir = norm(scratch_dir)

        -- declared projects (same definition as the <leader>fp picker)
        local project_parents = { norm(home .. "/projects") } -- every subfolder is a project
        local project_dirs = { norm(home .. "/.config/nvim"), norm("/etc/nixos") } -- single folders that are projects

        ---------------------------------------------------------------------------
        -- tab identity: t:project_root, falling back to the tab's cwd
        ---------------------------------------------------------------------------
        local function tab_has_root(tab)
            local ok, v = pcall(vim.api.nvim_tabpage_get_var, tab, "project_root")
            return ok and type(v) == "string"
        end

        local function tab_key(tab)
            local ok, v = pcall(vim.api.nvim_tabpage_get_var, tab, "project_root")
            if ok and type(v) == "string" then
                return v
            end
            -- getcwd(-1, tabnr): tab-local directory (or global if the tab has none)
            return norm(vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab)))
        end

        local function set_tab_root(tab, path)
            path = norm(path)
            vim.api.nvim_tabpage_set_var(tab, "project_root", path)
            vim.api.nvim_win_call(vim.api.nvim_tabpage_get_win(tab), function()
                vim.cmd.tcd(vim.fn.fnameescape(path))
            end)
        end

        local function find_tab(key)
            for _, t in ipairs(vim.api.nvim_list_tabpages()) do
                if tab_key(t) == key then
                    return t
                end
            end
        end

        -- the open project tab (deepest root) that contains this file, if any
        local function owning_tab_key(file)
            local best
            for _, t in ipairs(vim.api.nvim_list_tabpages()) do
                local c = tab_key(t)
                if c ~= home and c ~= "/" and c ~= scratch_dir and in_dir(file, c) then
                    if not best or #c > #best then
                        best = c
                    end
                end
            end
            return best
        end

        ---------------------------------------------------------------------------
        -- root detection for files that no open tab owns yet
        ---------------------------------------------------------------------------
        local function declared_root(file)
            for _, d in ipairs(project_dirs) do
                if in_dir(file, d) then
                    return d
                end
            end
            for _, parent in ipairs(project_parents) do
                if in_dir(file, parent) then
                    local name = file:sub(#parent + 2):match("^[^/]+")
                    -- must be inside a subfolder, not a loose file directly in ~/projects
                    if name and file ~= parent .. "/" .. name then
                        return parent .. "/" .. name
                    end
                end
            end
        end

        -- project.nvim forks differ in module name, so try both
        local function plugin_root(buf)
            for _, mod in ipairs({ "project_nvim.project", "project" }) do
                local ok, m = pcall(require, mod)
                if ok and type(m) == "table" and m.get_project_root then
                    local ok2, r = pcall(vim.api.nvim_buf_call, buf, function()
                        return (m.get_project_root())
                    end)
                    if ok2 and type(r) == "string" and r ~= "" then
                        return r
                    end
                end
            end
        end

        local function root_for(buf, file)
            local function valid(r)
                if type(r) ~= "string" or r == "" then
                    return nil
                end
                r = norm(r)
                if r == home or r == "/" or not in_dir(file, r) then
                    return nil
                end
                return r
            end
            return declared_root(file) or valid(plugin_root(buf)) or valid(vim.fs.root(vim.fs.dirname(file), markers))
        end

        ---------------------------------------------------------------------------
        -- per-tab buffer lists: only the current tab's project buffers stay listed
        ---------------------------------------------------------------------------
        local function refresh_listing()
            local cur = tab_key(vim.api.nvim_get_current_tabpage())
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(b) then
                    local name = vim.api.nvim_buf_get_name(b)
                    if vim.bo[b].buftype == "" and name ~= "" and not is_uri(name) then
                        local owner = owning_tab_key(norm_file(name)) or scratch_dir
                        if owner == cur then
                            if vim.b[b].tab_hidden then
                                vim.b[b].tab_hidden = nil
                                vim.bo[b].buflisted = true
                            end
                        elseif vim.bo[b].buflisted then
                            vim.b[b].tab_hidden = true
                            vim.bo[b].buflisted = false
                        end
                    end
                end
            end
        end

        local function real_buffers()
            local n = 0
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if vim.bo[b].buflisted and vim.bo[b].buftype == "" and vim.api.nvim_buf_get_name(b) ~= "" then
                    n = n + 1
                end
            end
            return n
        end

        ---------------------------------------------------------------------------
        -- persistence: one global session + the root of every tab
        ---------------------------------------------------------------------------
        local function save_state()
            if resetting or resession.is_loading() or resession.get_current() ~= session_name then
                return
            end
            local roots = {}
            for _, t in ipairs(vim.api.nvim_list_tabpages()) do
                roots[#roots + 1] = tab_key(t)
            end
            local cur = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
            pcall(vim.fn.writefile, { vim.json.encode({ tabs = roots, current = cur }) }, state_file)
        end

        local function save_current()
            resession.save(session_name, { dir = dir, notify = false })
            save_state()
        end

        local function restore_roots()
            local ok, data = pcall(function()
                return vim.json.decode(table.concat(vim.fn.readfile(state_file), "\n"))
            end)
            if not ok or type(data) ~= "table" or type(data.tabs) ~= "table" then
                return
            end
            local tabs = vim.api.nvim_list_tabpages()
            for i, t in ipairs(tabs) do
                local saved = data.tabs[i]
                if type(saved) == "string" and vim.fn.isdirectory(saved) == 1 then
                    set_tab_root(t, saved)
                end
            end
            if data.current and tabs[data.current] then
                vim.api.nvim_set_current_tabpage(tabs[data.current])
            end
        end

        vim.api.nvim_create_autocmd({ "TabNewEntered", "TabClosed", "TabEnter" }, {
            callback = function()
                vim.schedule(save_state)
            end,
        })
        vim.api.nvim_create_autocmd("TabEnter", { callback = refresh_listing })

        vim.api.nvim_create_autocmd("StdinReadPre", {
            callback = function()
                vim.g.using_stdin = true
            end,
        })

        vim.api.nvim_create_autocmd("VimEnter", {
            nested = true,
            callback = function()
                if vim.fn.argc(-1) > 0 or vim.g.using_stdin then
                    return
                end
                resession.load(session_name, { dir = dir, silence_errors = true })
                restore_roots()
                refresh_listing()

                if resession.get_current() ~= session_name then
                    save_current() -- first run: create + attach so autosave works
                end
                if real_buffers() == 0 then
                    Snacks.dashboard()
                end
            end,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                if resession.get_current() == session_name then
                    save_current()
                end
            end,
        })

        ---------------------------------------------------------------------------
        -- safety net: if anything (oil, project.nvim, :cd) moves a project tab's
        -- directory, put it back. Use :lcd if you really want a different dir.
        ---------------------------------------------------------------------------
        local restoring = false
        vim.api.nvim_create_autocmd("DirChanged", {
            pattern = { "global", "tabpage" },
            callback = function()
                if restoring or resetting or resession.is_loading() then
                    return
                end
                local tab = vim.api.nvim_get_current_tabpage()
                local ok, root = pcall(vim.api.nvim_tabpage_get_var, tab, "project_root")
                if not ok or type(root) ~= "string" then
                    return
                end
                if norm(vim.fn.getcwd(-1, 0)) ~= root then
                    restoring = true
                    vim.schedule(function()
                        if vim.api.nvim_tabpage_is_valid(tab) then
                            set_tab_root(tab, root)
                        end
                        restoring = false
                    end)
                end
            end,
        })

        ---------------------------------------------------------------------------
        -- route buffers to their project tab (or the scratch tab)
        ---------------------------------------------------------------------------
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                if resetting or resession.is_loading() then
                    return
                end
                local buf = args.buf
                if vim.bo[buf].buftype ~= "" then
                    return
                end

                local name = vim.api.nvim_buf_get_name(buf)
                if name == "" or is_uri(name) then -- skips oil://, etc.
                    return
                end

                local file = norm_file(name)
                local key = owning_tab_key(file) or root_for(buf, file) or scratch_dir
                if key == tab_key(vim.api.nvim_get_current_tabpage()) then
                    return
                end

                local win = vim.api.nvim_get_current_win()
                local prev = vim.fn.bufnr("#")

                vim.schedule(function()
                    -- bail if something already moved this buffer
                    if
                        not vim.api.nvim_buf_is_valid(buf)
                        or not vim.api.nvim_win_is_valid(win)
                        or vim.api.nvim_win_get_buf(win) ~= buf
                    then
                        return
                    end

                    local origin = vim.api.nvim_win_get_tabpage(win)
                    local has_prev = prev > 0
                        and prev ~= buf
                        and vim.api.nvim_buf_is_valid(prev)
                        and vim.api.nvim_buf_is_loaded(prev)
                        and vim.api.nvim_buf_get_name(prev) ~= ""

                    local target = find_tab(key)

                    -- a fresh tab with no project yet (startup, dashboard): adopt it
                    if not target and not has_prev and not tab_has_root(origin) then
                        set_tab_root(origin, key)
                        refresh_listing()
                        save_state()
                        return
                    end

                    -- leave the origin tab as it was
                    if has_prev then
                        vim.api.nvim_win_set_buf(win, prev)
                    else
                        vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(false, true))
                    end

                    if target then
                        vim.api.nvim_set_current_tabpage(target)
                        vim.api.nvim_win_set_buf(0, buf)
                    else
                        vim.cmd("$tabnew")
                        vim.bo[vim.api.nvim_get_current_buf()].bufhidden = "wipe"
                        set_tab_root(vim.api.nvim_get_current_tabpage(), key)
                        vim.api.nvim_win_set_buf(0, buf)
                    end

                    refresh_listing()
                    save_state()
                end)
            end,
        })

        ---------------------------------------------------------------------------
        -- project switcher
        ---------------------------------------------------------------------------
        local function open_project(path)
            path = norm(path)

            local t = find_tab(path)
            if t then
                vim.api.nvim_set_current_tabpage(t)
                return
            end

            local cur = vim.api.nvim_get_current_tabpage()
            local reusable = vim.api.nvim_buf_get_name(0) == ""
                and #vim.api.nvim_tabpage_list_wins(0) == 1
                and not tab_has_root(cur)
            if not reusable then
                vim.cmd("$tabnew")
            end
            set_tab_root(vim.api.nvim_get_current_tabpage(), path)
            refresh_listing()
            save_state()
            Snacks.picker.files({ cwd = path })
        end

        vim.keymap.set("n", "<leader>fp", function()
            local items = {}
            for _, root in ipairs(project_parents) do
                for name, type in vim.fs.dir(root) do
                    if type == "directory" then
                        items[#items + 1] = { text = name, file = root .. "/" .. name }
                    end
                end
            end

            table.sort(items, function(a, b)
                return a.text < b.text
            end)

            -- single-folder projects go at the top, in the order listed
            for i = #project_dirs, 1, -1 do
                local d = project_dirs[i]
                table.insert(items, 1, {
                    text = vim.fn.fnamemodify(d, ":h:t") .. "/" .. vim.fn.fnamemodify(d, ":t"),
                    file = d,
                })
            end

            Snacks.picker({
                title = "Projects",
                items = items,
                format = function(item)
                    return { { item.text, "SnacksPickerFile" } }
                end,
                preview = "directory",
                layout = { preset = "select" },
                confirm = function(picker, item)
                    picker:close()
                    if item then
                        vim.schedule(function()
                            open_project(item.file)
                        end)
                    end
                end,
            })
        end, { desc = "Open/switch project tab" })

        vim.keymap.set("n", "<leader>ps", save_current, { desc = "Save session" })

        ---------------------------------------------------------------------------
        -- :ProjectReset - wipe tabs, buffers, LSP clients, the saved session and
        -- the saved tab roots, then start a fresh session. :ProjectReset! skips
        -- the confirmation.
        ---------------------------------------------------------------------------
        local function reset_all()
            resetting = true

            -- stop autosave and delete the saved session + tab roots
            pcall(resession.detach)
            pcall(resession.delete, session_name, { dir = dir, notify = false })
            pcall(vim.uv.fs_unlink, state_file)

            for _, c in ipairs(vim.lsp.get_clients()) do
                pcall(function()
                    c:stop(true)
                end)
            end

            -- collapse to one tab with one window and forget its project
            pcall(vim.cmd, "tabonly")
            pcall(vim.cmd, "only")
            pcall(vim.api.nvim_tabpage_del_var, vim.api.nvim_get_current_tabpage(), "project_root")

            -- wipe every buffer (including oil and hidden ones), one at a time
            local blank = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_win_set_buf(0, blank)
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if b ~= blank and vim.api.nvim_buf_is_valid(b) then
                    pcall(vim.api.nvim_buf_delete, b, { force = true })
                end
            end

            -- back to a plain global cwd
            pcall(vim.cmd.cd, vim.fn.fnameescape(home))

            vim.schedule(function()
                resetting = false
                save_current() -- fresh session, attached so autosave keeps working
                if Snacks and Snacks.dashboard then
                    Snacks.dashboard()
                end
                vim.notify("Project tabs and session reset")
            end)
        end

        vim.api.nvim_create_user_command("ProjectReset", function(opts)
            if
                opts.bang
                or vim.fn.confirm(
                        "Reset all tabs, buffers and the saved session? Unsaved changes are lost.",
                        "&Yes\n&No",
                        2
                    )
                    == 1
            then
                reset_all()
            end
        end, { bang = true, desc = "Reset tabs, buffers and session" })

        -- debugging: shows each tab's identity and cwd
        vim.api.nvim_create_user_command("ProjectTabs", function()
            for i, t in ipairs(vim.api.nvim_list_tabpages()) do
                print(
                    i,
                    "key=" .. tab_key(t),
                    "cwd=" .. vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(t)),
                    tab_has_root(t) and "" or "(no root set)"
                )
            end
        end, {})
    end,
}
