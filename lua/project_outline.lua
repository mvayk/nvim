-- project_outline.lua
-- Project-wide overview of files + their function/class signatures,
-- shown in a snacks.nvim picker. Uses treesitter (no LSP needed) and
-- parses files from disk without opening buffers.
--
-- Install: save as  ~/.config/nvim/lua/project_outline.lua
--   require("project_outline").setup()
--   vim.keymap.set("n", "<leader>so", function() require("project_outline").pick() end)
--
-- Commands:
--   :ProjectOutline          snacks picker (fuzzy search over every signature)
--   :ProjectOutline buffer   dump the whole outline into a markdown scratch buffer

local M = {}
local uv = vim.uv or vim.loop

M.config = {
    max_file_size = 200 * 1024, -- skip files bigger than this (bytes)
    max_signature_len = 120, -- truncate long signatures
    show_empty_files = false, -- list files that have no symbols too
    exclude = { "%.min%.", "%-lock%.", "%.lock$", "%.svg$", "%.map$" }, -- lua patterns on path
    cwd = nil, -- default: git root, else cwd
}

-- Nodes that are listed AND whose children are searched (classes, impls, ...)
local CONTAINERS = {
    class_declaration = true,
    abstract_class_declaration = true,
    class_definition = true,
    class_specifier = true,
    class = true, -- ruby
    module = true, -- ruby
    impl_item = true,
    trait_item = true,
    mod_item = true,
    namespace_definition = true,
    interface_declaration = true,
}

-- Nodes that are listed but not descended into (functions, types)
local LEAVES = {
    function_declaration = true,
    generator_function_declaration = true,
    function_definition = true,
    function_item = true,
    method_declaration = true,
    method_definition = true,
    constructor_declaration = true,
    method = true, -- ruby
    singleton_method = true, -- ruby
    struct_item = true,
    struct_specifier = true,
    enum_item = true,
    enum_declaration = true,
    type_alias_declaration = true,
    type_declaration = true, -- go
}

-- Per-language node types to ignore (e.g. lua's `function_definition` is an anonymous fn)
local SKIP = {
    lua = { function_definition = true },
}

local FUNC_VALUES = { arrow_function = true, function_expression = true, ["function"] = true }

---------------------------------------------------------------------------
-- helpers
---------------------------------------------------------------------------

local function clean(sig, maxlen)
    sig = sig:gsub("%s+", " ")
    sig = sig:gsub("^ ", "")
    sig = sig:gsub("%s*[{:]$", "")
    if vim.fn.strchars(sig) > maxlen then
        sig = vim.fn.strcharpart(sig, 0, maxlen - 1) .. "…"
    end
    return sig
end

--- text from the start of `start_node` up to the start of `body` (or first line)
local function extract(src, start_node, body)
    local text
    if body then
        local _, _, sb = start_node:start()
        local _, _, bb = body:start()
        text = src:sub(sb + 1, bb)
    else
        text = vim.treesitter.get_node_text(start_node, src):match("[^\n]*")
    end
    return text
end

local function walk(node, src, lang, depth, out, maxlen)
    local skip = SKIP[lang] or {}
    for child in node:iter_children() do
        if child:named() then
            local t = child:type()
            local sig, descend = nil, false

            if not skip[t] then
                if CONTAINERS[t] then
                    sig, descend = extract(src, child, child:field("body")[1]), true
                elseif LEAVES[t] then
                    sig = extract(src, child, child:field("body")[1])
                elseif t == "variable_declarator" then
                    -- js/ts: const foo = (a, b) => {}
                    local value = child:field("value")[1]
                    if value and FUNC_VALUES[value:type()] then
                        local start = child
                        local p = child:parent()
                        if p and (p:type() == "lexical_declaration" or p:type() == "variable_declaration") then
                            start = p
                        end
                        sig = extract(src, start, value:field("body")[1])
                    end
                elseif t == "assignment_statement" and lang == "lua" then
                    -- lua: M.foo = function(a, b) ... end
                    local right = child:named_child(1)
                    local fn = right and right:type() == "expression_list" and right:named_child(0)
                    if fn and fn:type() == "function_definition" then
                        sig = extract(src, child, fn:field("body")[1])
                    end
                end
            end

            if sig then
                local row, col = child:start()
                out[#out + 1] = { sig = clean(sig, maxlen), row = row + 1, col = col, depth = depth, kind = t }
                if descend then
                    walk(child, src, lang, depth + 1, out, maxlen)
                end
            else
                walk(child, src, lang, depth, out, maxlen)
            end
        end
    end
end

local parser_ok = {}
local function get_lang(path)
    local ft = vim.filetype.match({ filename = path })
    if not ft then
        return
    end
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if parser_ok[lang] == nil then
        local ok, res = pcall(vim.treesitter.language.add, lang)
        parser_ok[lang] = (ok and res ~= false) and true or false
    end
    return parser_ok[lang] and lang or nil
end

local function read_file(path, max)
    local fd = uv.fs_open(path, "r", 438)
    if not fd then
        return
    end
    local stat = uv.fs_fstat(fd)
    local data
    if stat and stat.size > 0 and stat.size <= max then
        data = uv.fs_read(fd, stat.size, 0)
    end
    uv.fs_close(fd)
    if data and data:find("\0", 1, true) then
        return
    end
    return data
end

local function list_files(root)
    local cmds = {
        { "git", "ls-files", "--cached", "--others", "--exclude-standard" },
        { "rg", "--files", "--hidden", "-g", "!.git" },
        { "fd", "-t", "f", "--hidden", "--exclude", ".git" },
    }
    for _, cmd in ipairs(cmds) do
        if vim.fn.executable(cmd[1]) == 1 then
            local res = vim.system(cmd, { cwd = root, text = true }):wait()
            if res.code == 0 and res.stdout and res.stdout ~= "" then
                return vim.split(res.stdout, "\n", { trimempty = true })
            end
        end
    end
    return {}
end

---------------------------------------------------------------------------
-- collect
---------------------------------------------------------------------------

--- Returns a flat list of items { file, row, col, sig, depth, kind }, and the root.
function M.collect(opts, yield)
    opts = vim.tbl_deep_extend("force", M.config, opts or {})
    local root = opts.cwd
    if not root then
        local ok, git_root = pcall(function()
            return Snacks.git.get_root()
        end)
        root = (ok and git_root) or uv.cwd()
    end

    local items = {}
    for i, rel in ipairs(list_files(root)) do
        local excluded = false
        for _, pat in ipairs(opts.exclude) do
            if rel:find(pat) then
                excluded = true
                break
            end
        end

        local lang = not excluded and get_lang(rel) or nil
        local src = lang and read_file(root .. "/" .. rel, opts.max_file_size) or nil

        if src then
            local symbols = {}
            local ok, parser = pcall(vim.treesitter.get_string_parser, src, lang)
            if ok then
                local parsed = parser:parse()
                if parsed and parsed[1] then
                    pcall(walk, parsed[1]:root(), src, lang, 0, symbols, opts.max_signature_len)
                end
            end
            for _, s in ipairs(symbols) do
                s.file = rel
                items[#items + 1] = s
            end
            if #symbols == 0 and opts.show_empty_files then
                items[#items + 1] = { file = rel, row = 1, col = 0, sig = "", depth = 0, kind = "file" }
            end
        elseif not excluded and opts.show_empty_files then
            items[#items + 1] = { file = rel, row = 1, col = 0, sig = "", depth = 0, kind = "file" }
        end

        if yield and i % 25 == 0 then
            yield()
        end
    end
    return items, root
end

---------------------------------------------------------------------------
-- snacks picker
---------------------------------------------------------------------------

function M.pick(opts)
    opts = vim.tbl_deep_extend("force", M.config, opts or {})
    local width = 20

    Snacks.picker({
        title = "Project Outline",
        cwd = opts.cwd,
        preview = "file",
        finder = function(_, ctx)
            local function yield()
                if ctx and ctx.async then
                    pcall(function()
                        ctx.async:sleep(1)
                    end)
                end
            end

            local items, root = M.collect(opts, yield)
            width = 20
            for _, it in ipairs(items) do
                width = math.max(width, math.min(#it.file, 50))
            end
            for _, it in ipairs(items) do
                it.cwd = root
                it.pos = { it.row, it.col }
                it.text = it.file .. " " .. it.sig
            end
            return items
        end,
        format = function(item)
            local file = item.file
            if #file > 50 then
                file = "…" .. file:sub(-49)
            end
            return {
                { ("%-" .. width .. "s"):format(file), "SnacksPickerDir" },
                { "  " },
                { string.rep("  ", item.depth) .. item.sig },
            }
        end,
    })
end

---------------------------------------------------------------------------
-- plain-text dump (handy to read, or paste into an LLM)
---------------------------------------------------------------------------

function M.buffer(opts)
    local items = M.collect(opts)
    local lines, last = {}, nil
    for _, it in ipairs(items) do
        if it.file ~= last then
            if last then
                lines[#lines + 1] = ""
            end
            lines[#lines + 1] = "## " .. it.file
            last = it.file
        end
        if it.sig ~= "" then
            lines[#lines + 1] = ("%s%s  -- L%d"):format(string.rep("  ", it.depth), it.sig, it.row)
        end
    end

    vim.cmd("vnew")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].modifiable = false
    pcall(vim.api.nvim_buf_set_name, buf, "ProjectOutline")
end

---------------------------------------------------------------------------

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
    vim.api.nvim_create_user_command("ProjectOutline", function(a)
        if a.args == "buffer" then
            M.buffer()
        else
            M.pick()
        end
    end, {
        nargs = "?",
        complete = function()
            return { "buffer" }
        end,
    })
end

return M
