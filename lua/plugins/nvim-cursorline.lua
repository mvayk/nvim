return {
    "ya2s/nvim-cursorline",
    enabled = true,
    lazy = false,
    event = "VeryLazy",
    config = function()
        require("nvim-cursorline").setup({
            cursorline = {
                enable = false,
                timeout = 0,
                number = true,
            },

            cursorcolumn = {
                enable = false,
                timeout = 0,
                number = true,
            },

            cursorword = {
                enable = false,
                min_length = 3,
                hl = { underline = true, undercurl = false },
            },
        })
    end,
}
