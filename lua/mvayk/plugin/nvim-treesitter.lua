return {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").setup({})
        require("nvim-treesitter").install({ "rust", "lua" })
    end,
}
