return {
    "ggandor/leap.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("leap").set_default_mappings()
    end,
}
