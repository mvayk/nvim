return {
    "romgrk/barbar.nvim",
    enabled = false,
    dependencies = {
        require("mvayk.settings").icon_theme_package,
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {
        preset = "powerline",
        separator = {
            left = "",
            right = "",
        },

        animation = true,
        sidebar_filetypes = {
            NvimTree = true,
            neo_tree = true,
        },
    },
}
