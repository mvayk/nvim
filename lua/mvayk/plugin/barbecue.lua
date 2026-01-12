return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
    },

    config = function()
        require("barbecue").setup({
            theme = {
                normal = { bg = "NONE" },
            },
        })
    end
}
