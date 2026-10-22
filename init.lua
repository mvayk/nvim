require("mvayk.core")

local anti_background = require("mvayk.transparency")

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

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        if settings.transparent_background then
            vim.schedule(anti_background)
        end
    end,
})

if settings.use_matugen then
    require("matugen").setup()
end
