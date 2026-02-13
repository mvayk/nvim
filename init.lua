require("mvayk")

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

local theme_file = vim.fn.stdpath("data") .. "/last_theme.lua"

local ok, err = pcall(dofile, theme_file)
if not ok then
    vim.o.background = "dark"
    vim.cmd([[colorscheme vague]])
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local file = io.open(theme_file, "w")
        if file then
            file:write(string.format([[
vim.o.background = "%s"
vim.cmd.colorscheme("%s")
            ]], vim.o.background, vim.g.colors_name))
            file:close()
        end
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
})

--// use terminal colors
--vim.o.termguicolors = false
--vim.o.background = 'dark'  -- or 'light'
--vim.cmd([[colorscheme tokyobones]])

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
