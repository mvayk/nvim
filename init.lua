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

require("mvayk.core.config")

require("lazy").setup({
    import = "mvayk.plugin",
})

local settings = require("mvayk.settings")

local ok, _ = pcall(dofile, settings.theme_file)
if not ok then
    print("Creating theme file")
    vim.o.background = "dark"
    vim.cmd([[colorscheme rose-pine]])
end

if settings.use_base16_colorscheme then
    require("matugen").setup()
end
