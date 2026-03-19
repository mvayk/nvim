return {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" } -- fallback to indent if treesitter fails
        end,
    },
}
