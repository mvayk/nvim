local enabled = false

if enabled then
    return {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    show_buffer_close_icons = false,
                    show_close_icon = false,

                    indicator = {
                        style = "icon",             -- ← changes to underline instead of icon
                    },

                    -- Optional: tweak separator if underline alone looks too plain
                    separator_style = "thin",          -- or "slant", "thick", "slope" – thin looks clean with underline

                    always_show_bufferline = true,
                }
            })
        end
    }
else
    return { }
end
