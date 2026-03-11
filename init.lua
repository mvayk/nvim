require("mvayk.core")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    import = "mvayk.plugin",
})

require("mvayk.core.config")
local settings = require("mvayk.settings")

local ok, _ = pcall(dofile, settings.theme_file)
if not ok then
    print("Creating theme file")
    vim.o.background = "dark"
    vim.cmd([[colorscheme rose-pine]])
end

--// use terminal colors
--vim.o.termguicolors = false
--vim.o.background = 'dark'  -- or 'light'
--vim.cmd([[colorscheme tokyobones]])
--normal_background()
--anti_anti_background()
