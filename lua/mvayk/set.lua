vim = vim
vim.o.background = "dark"

-- remove auto commentting  feature
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.list = false
    end,
})

vim.opt.nu = true
vim.opt.fileformats = {'unix', 'dos'} --// fixes windows line endings
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.scrolloff = 1923800
vim.opt.clipboard = "unnamedplus"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.signcolumn = "yes:3"
-- :bd!
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
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.opt["guicursor"] = "i:block"
-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }

vim.o.list = true
-- vim.opt.listchars = {
--     space = "⋅",
--     eol = "↴",
--     tab = "▎_",
--     tab = "󰄾 ",
--     trail = "•",
--     extends = "❯",
--     precedes = "❮",
--     nbsp = "",
-- }
-- vim.opt.fillchars = {
--     fold = " ",
--     foldsep = " ",
--     foldopen = "",
--     foldclose = "",
--     diff = "╱",
-- }

vim.opt.fillchars:append({
  fold      = " ",
  foldopen  = "",
  foldclose = "",
  foldsep   = "│",
})

vim.opt.foldcolumn     = "1"
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable     = true
vim.opt.signcolumn     = "yes"

--> lsp hover diagnostics thing <--
vim.o.updatetime = 250  -- faster CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end
})
