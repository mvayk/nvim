return {
    "stevearc/overseer.nvim",
    enable = true,
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    config = function()
        require("overseer").setup({})
    end,
}
