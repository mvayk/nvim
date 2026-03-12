local enabled = false
if enabled then
    return {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional
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
else
    return {}
end
