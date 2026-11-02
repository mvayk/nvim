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

--[[ just in case ]]
vim.api.nvim_create_autocmd("ColorSchemePre", {
    callback = function()
        vim.cmd("highlight clear")
        if vim.fn.exists("syntax_on") == 1 then
            vim.cmd("syntax reset")
        end
    end,
})

local anti_background = require("transparency")
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })
        if settings.transparent_background then
            vim.schedule(anti_background)
        end

        -- if it works its a good code ok
        if vim.g.neovide == true then
            vim.o.cursorline = false
            vim.o.cursorcolumn = false

            if settings.neovide_line_modes == true then
                vim.o.cursorline = true
                vim.o.cursorcolumn = false

                vim.api.nvim_create_autocmd("InsertEnter", {
                    callback = function()
                        vim.o.cursorline = true
                        vim.o.cursorcolumn = false
                    end,
                })

                vim.api.nvim_create_autocmd("InsertLeave", {
                    callback = function()
                        vim.o.cursorline = true
                        vim.o.cursorcolumn = false
                    end,
                })
            end
        else
            vim.o.cursorline = false
            vim.o.cursorcolumn = false
            vim.opt["guicursor"] = "i:block"
        end
    end,
})

require("neovide").setup()
