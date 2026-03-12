return {
    "nvimdev/dashboard-nvim",
    enabled = false,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local dashboard = require("dashboard").setup({
            theme = "hyper",
        })
    end,
}
