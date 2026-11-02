local enabled = vim.g.neovide

if enabled then
    --[[ vim.api.nvim_create_autocmd("BufHidden", {
        group = vim.api.nvim_create_augroup("close_hidden_buffers", { clear = true }),
        callback = function(args)
            local buf = args.buf
            vim.schedule(function()
                if not vim.api.nvim_buf_is_valid(buf) then
                    return
                end
                if vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == "" then
                    return
                end
                if #vim.fn.win_findbuf(buf) > 0 then
                    return
                end
                if vim.bo[buf].modified then
                    pcall(vim.api.nvim_buf_call, buf, function()
                        vim.cmd("silent! write")
                    end)
                end
                if not vim.bo[buf].modified then
                    pcall(vim.api.nvim_buf_delete, buf, {})
                end
            end)
        end,
    }) ]]

    return {
        "stevearc/resession.nvim",
        enabled = true,
        lazy = false,
        config = function()
            local resession = require("resession")
            resession.setup({
                autosave = { enabled = true, interval = 60, notify = false },
            })

            local dir = "dirsession"
            local last_file = vim.fn.stdpath("state") .. "/last_project"

            local function real_buffers()
                local n = 0
                for _, b in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.bo[b].buflisted and vim.bo[b].buftype == "" and vim.api.nvim_buf_get_name(b) ~= "" then
                        n = n + 1
                    end
                end
                return n
            end

            local function save_current()
                resession.save(vim.fn.getcwd(), { dir = dir, notify = false })
                vim.fn.writefile({ vim.fn.getcwd() }, last_file)
            end

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
                    if vim.fn.getcwd() == vim.env.HOME and vim.fn.filereadable(last_file) == 1 then
                        vim.cmd.cd(vim.fn.fnameescape(vim.fn.readfile(last_file)[1]))
                    end
                    resession.load(vim.fn.getcwd(), { dir = dir, silence_errors = true })

                    -- NEW: nothing restored? show the dashboard
                    if real_buffers() == 0 then
                        Snacks.dashboard()
                    end
                end,
            })

            vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_current })

            local function switch_project(path)
                vim.g.switching_project = true
                save_current()
                for _, c in ipairs(vim.lsp.get_clients()) do
                    c:stop(true)
                end
                vim.cmd("silent! %bwipeout!")
                vim.cmd.cd(vim.fn.fnameescape(path))
                resession.load(path, { dir = dir, silence_errors = true })

                vim.schedule(function()
                    vim.g.switching_project = false
                    if real_buffers() == 0 then
                        Snacks.picker.files({ cwd = path })
                    end
                end)
            end

            vim.keymap.set("n", "<leader>fp", function()
                local home = vim.env.HOME
                local roots = { home .. "/projects" } -- every subfolder is a project
                local extras = { home .. "/.config/nvim" } -- single folders that are projects themselves

                local items = {}
                for _, root in ipairs(roots) do
                    for name, type in vim.fs.dir(root) do
                        if type == "directory" then
                            items[#items + 1] = { text = name, file = root .. "/" .. name }
                        end
                    end
                end

                table.sort(items, function(a, b)
                    return a.text < b.text
                end)

                -- extras go at the top, in the order listed
                for i = #extras, 1, -1 do
                    table.insert(items, 1, {
                        text = vim.fn.fnamemodify(extras[i], ":h:t") .. "/" .. vim.fn.fnamemodify(extras[i], ":t"),
                        file = extras[i],
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
                                switch_project(item.file)
                            end)
                        end
                    end,
                })
            end, { desc = "Switch project" })

            vim.keymap.set("n", "<leader>ps", save_current, { desc = "Save project session" })
        end,
    }
else
    return {}
end
