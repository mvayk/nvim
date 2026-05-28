return {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
    lazy = true,
    config = function()
        require("colorizer").setup({})
    end,
}
