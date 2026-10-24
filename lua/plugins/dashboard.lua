return {
    "nvimdev/dashboard-nvim",
    enabled = false,
    lazy = false,
    dependencies = { require("settings").icon_theme_package },
    config = function()
        local dashboard = require("dashboard").setup({
            theme = "hyper",
        })
    end,
}
