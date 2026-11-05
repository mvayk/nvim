local settings = require("settings")
return {
    "nvim-lualine/lualine.nvim",
    enabled = settings.neovide_ancient,
    lazy = false,
    dependencies = { require("settings").icon_theme_package.git },
    config = function()
        if not require("settings").neovide_ancient then
            require("lualine").setup({})
        end
    end,
}
