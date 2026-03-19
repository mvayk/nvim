local settings = require("mvayk.settings")

vim = vim
vim.o.updatetime = 0
vim.opt.nu = true
vim.opt.fileformats = { "unix", "dos" } --// fixes windows line endings
vim.opt.relativenumber = true
vim.opt.tabstop = 4
--vim.opt.scrolloff = 1923800
vim.opt.scrolloff = 12
vim.opt.clipboard = "unnamedplus"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
--// vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.o.exrc = true
vim.o.cursorline = false
vim.o.cursorcolumn = false
--vim.opt["guicursor"] = "i:block"
-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }

vim.o.list = true
vim.opt.listchars = {
    --space = "⋅",
    --eol = "↴",
    --lead = "⋅",
    --tab = "▎_",
    tab = "󰄾 ",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "",
}
-- vim.opt.fillchars = {
--     fold = " ",
--     foldsep = " ",
--     foldopen = "",
--     foldclose = "",
--     diff = "╱",
-- }

vim.opt.fillchars:append({
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    --foldsep   = "│",
})

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.signcolumn = "yes"

local map = vim.keymap.set
vim.g.mapleader = " "

--map("n", "<leader>pv", vim.cmd.Ex) -- i dont know what this is but it must be important!
--// Vanilla
map("n", "<C-n>", ":bnext<CR>", { desc = "Goto next buffer" })
map("n", "<C-p>", ":bprev<CR>", { desc = "Goto previous buffer" })
map("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>w", ":w<CR>", { desc = "Write file" })
map("n", "<leader>q", ":q!<CR>", { desc = "Force quit" })
map({ "n", "x", "o" }, "<C-x>", "/\\s<CR>", { desc = "Jump to next space", silent = true })
map({ "n", "x", "o" }, "<C-a>", "?\\s<CR>", { desc = "Jump to previous space", silent = true })
map("n", "mq", ":bd!<CR>", { desc = "Force delete buffer", silent = true })
map("i", "<C-y>", '<C-r>"', { desc = "Yank last delete" })
map("n", "j", "gj", { buffer = true, noremap = true, silent = true })
map("n", "k", "gk", { buffer = true, noremap = true, silent = true })
map("v", "j", "gj", { buffer = true, noremap = true, silent = true })
map("v", "k", "gk", { buffer = true, noremap = true, silent = true })
map("n", "<C-j>", "o<Esc>", { desc = "Insert line below" })
map("n", "<C-k>", "O<Esc>", { desc = "Insert line above" })

--// LSP Related
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ld", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Goto definition" })

map("n", "<leader>lgd", "<CMD>Glance definitions<CR>")
map("n", "<leader>lgr", "<CMD>Glance references<CR>")
map("n", "<leader>lgt", "<CMD>Glance type_definitions<CR>")
map("n", "<leader>lgi", "<CMD>Glance implementations<CR>")

map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
map({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format document/range" })
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "<leader>lw", function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = "Workspace symbols" })
map("n", "<leader>ll", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>l[", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "<leader>l]", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics float" })

local function toggle_completion()
    require("blink.cmp").hide()
    vim.b.completion = not vim.b.completion
    vim.notify("Completion " .. (vim.b.completion and "enabled" or "disabled"), vim.log.levels.INFO)
end

vim.keymap.set({ "n" }, "<leader>lz", toggle_completion, { desc = "Toggle Completion in its entirety" })

vim.keymap.set("n", "<leader>lc", function()
    require("blink.cmp").hide()
    vim.b.menu_auto_show = not vim.b.menu_auto_show
    vim.notify("Menu auto-show: " .. (vim.b.menu_auto_show and "ON" or "OFF"))
end, { desc = "Toggle popup menu auto-show" })

--// Folding
map("n", "<CR>", "za", { desc = "Toggle fold" })

--// Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open oil / parent directory" })

--// Dired
vim.keymap.set("n", "_", "<CMD>Dired<CR>", { desc = "Open dired / parent directory" })

--// foaming at the mouth

--// Snacks Telescope
Snacks = Snacks
map("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Open telescope" })
map("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Telescope buffers" })
map("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Telescope git files" })
map("n", "<leader>fi", function()
    Snacks.picker.git_log()
end, { desc = "Telescope git" })
map("n", "<leader>/", function()
    Snacks.picker.grep()
end, { desc = "Telescope grep" })

--// Snacks Explorer
map("n", "<leader>e", function()
    Snacks.explorer()
end, { desc = "Open file explorer" })

--// Snacks colorscheme selector
vim.keymap.set("n", "<leader>ts", function()
    Snacks.picker.colorschemes()
end, { desc = "Select Colorschemes (Snacks Picker)" })

local function anti_background()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "FoldColumn",
        "EndOfBuffer",
        "DiagnosticSignError",
        "DiagnosticSignWarn",
        "DiagnosticSignInfo",
        "DiagnosticSignHint",
        "LspCodeActionSign",

        "FloatBorder",
        -- "Pmenu",
        -- "PmenuSel",
        -- "PmenuSbar",
        -- "PmenuThumb",
        "WinSeparator",
        "StatusLine",
        "StatusLineNC",

        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeFloatBorder",
        "NeoTreeTitleBar",
        "NeoTreeWinSeparator",
        "NeoTreeFileName",
        "NeoTreeDirectoryName",
        "NeoTreeRootName",
        "NeoTreeGitUntracked",
        "NeoTreeGitModified",

        "lualine_a_normal",
        "lualine_b_normal",
        "lualine_c_normal",
        "lualine_x_normal",
        "lualine_y_normal",
        "lualine_z_normal",
        "lualine_a_insert",
        "lualine_b_insert",
        "lualine_c_insert",
        "lualine_x_insert",
        "lualine_y_insert",
        "lualine_z_insert",

        "SnacksPicker",
        "SnacksPickerBorder",
        "SnacksPickerTitle",
        "SnacksPickerInput",
        "SnacksPickerList",
        "SnacksPickerPreview",
        "SnacksPickerPrompt",
        "SnacksPickerDir",
        "SnacksPickerMatch",
        "SnacksPickerIcon",
        --"SnacksPickerCursorLine",
        --"SnacksPickerListCursorLine",
        "SnacksDashboard",
        "SnacksDashboardIcon",
        "SnacksDashboardDesc",
        "SnacksDashboardKey",
        "SnacksDashboardTitle",

        "SnacksNotifierInfo",
        "SnacksNotifierWarn",
        "SnacksNotifierError",
        "SnacksNotifierDebug",
        "SnacksNotifierTrace",
        "SnacksNotifierBorder",
    }

    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end

    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#cccccc" })

    -- nixos shenanigans cause this to be undercurled for some reason probably
    --vim.api.nvim_set_hl(0, "@lsp.type.unresolvedReference", { undercurl = false })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local file = io.open(settings.theme_file, "w")
        if file then
            file:write(string.format(
                [[
                vim.o.background = "%s"
                vim.cmd.colorscheme("%s")
                ]],
                vim.o.background,
                vim.g.colors_name
            ))
            file:close()
        end
        if settings.transparent_background then
            anti_background()
        end
    end,
})

vim.keymap.set("n", "<leader>tb", function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.notify("Toggled Light")
    else
        vim.o.background = "dark"
        vim.notify("Toggled Dark")
    end
    if settings.transparent_background then
        anti_background()
    end
end, { desc = "Toggle background" })

vim.api.nvim_create_autocmd("cursorhold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            border = settings.border,
            source = "always",
            prefix = " ",
            scope = "line",
            relative = "win",
            anchor = "NE",
            row = 0,
            col = vim.api.nvim_win_get_width(0) - 2,
            max_width = 85,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown, org",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.list = false
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = "a:ver25-blinkon0"
    end,
})

--[[ vim.api.nvim_create_autocmd( {"CursorHold", "CursorHoldI" }, {
    callback = function()
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
        if #diagnostics > 0 then
            local float_bufnr, winid = vim.diagnostic.open_float(nil, {
                focus = false,
                focusable = false,
                border = "none",
                source = "always",
                max_width = 39,
                prefix = " ",
                scope = "line",
                close_events = {
                    "CursorMoved",
                    "CursorMovedI",
                    "InsertEnter",
                    "InsertLeave",
                    "BufLeave",
                    "BufHidden",
                    "InsertCharPre",
                    "TextChanged",
                    "TextChangedI",
                },
            })

            if winid then
                vim.api.nvim_win_set_config(winid, {
                    relative = "editor",
                    anchor = "NE",
                    row = 1,
                    col = vim.o.columns,
                })
            end
        end
    end
}) ]]
