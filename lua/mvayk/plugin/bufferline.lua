return {
    "akinsho/bufferline.nvim",
    enabled = false,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                show_buffer_close_icons = false,
                show_close_icon = false,

                highlights = {
                    background = {
                        fg = "NONE",
                        bg = "NONE",
                    },
                },

                indicator = {
                    style = "icon",
                },

                separator_style = "slope",
                always_show_bufferline = true,
            },
        })
    end,
}
