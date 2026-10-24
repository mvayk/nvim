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

require("core.config")

require("lazy").setup({
    import = "plugins",
})

local settings = require("settings")
local ok, _ = pcall(dofile, settings.theme_file)
if not ok then
    print("Creating theme file")
    vim.o.background = "dark"
    vim.cmd([[colorscheme rose-pine]])
end

local anti_background = require("transparency")
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("UserTransparency", { clear = true }),
    callback = function()
        if settings.transparent_background then
            vim.schedule(anti_background)
        end
    end,
})
