return {
    "nvimdev/dashboard-nvim",
    enabled = true,
    lazy = false,
    dependencies = { require("settings").icon_theme_package.git },
    config = function()
        local dashboard = require("dashboard").setup({
            theme = "hyper",
        })
    end,
}
