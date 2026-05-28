return {
    "s1n7ax/nvim-window-picker",
    enabled = false,
    name = "window-picker",
    lazy = true,
    event = "VeryLazy",
    version = "2.*",
    config = function()
        require("window-picker").setup()
    end,
}
