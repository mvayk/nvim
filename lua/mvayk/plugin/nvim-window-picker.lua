return {
    "s1n7ax/nvim-window-picker",
    enabled = true,
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
        require("window-picker").setup()
    end,
}
