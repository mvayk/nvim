return {
    "romgrk/barbar.nvim",
    enabled = false,
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {
        icons = {
            preset = "none",
        },

        sidebar_filetypes = {
            -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
            NvimTree = true,
            -- Or, specify the text used for the offset:
            undotree = {
                text = "undotree",
                align = "center", -- *optionally* specify an alignment (either 'left', 'center', or 'right')
            },
            -- Or, specify the event which the sidebar executes when leaving:
            ["neo-tree"] = { event = "BufWipeout" },
            -- Or, specify all three
            Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
        },
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
