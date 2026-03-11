local config = require("mvayk.config")

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

--[[========================================================================
    AUTOCMD
============================================================================]]

vim.api.nvim_create_autocmd("cursorhold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            border = config.border,
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


