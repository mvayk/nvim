return {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require("neopywal").setup({
            use_pallete = "wallust",
        })
        vim.cmd.colorscheme("neopywal")
    end,
}
