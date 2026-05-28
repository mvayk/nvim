return {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", require("mvayk.settings").icon_theme_package },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        require("render-markdown").setup({
            completions = { lsp = { enabled = true } },
        })
    end,
}
