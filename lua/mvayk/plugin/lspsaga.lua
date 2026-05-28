return {
    "nvimdev/lspsaga.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("lspsaga").setup({})
    end,
}
