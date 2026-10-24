return {
    "petertriho/nvim-scrollbar",
    enabled = false,
    lazy = false,
    event = "VeryLazy",
    config = function()
        require("scrollbar").setup({})
    end,
}
