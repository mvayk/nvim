vim = vim
vim.o.background = "dark"

-- remove auto commentting  feature
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
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
vim.opt.signcolumn = "yes"
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
vim.opt["guicursor"] = "i:block"
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

--> lsp hover diagnostics thing <--
vim.o.updatetime = 250  -- faster CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end
})
vim.keymap.set("n", "<leader>,", vim.diagnostic.open_float)
