return {
    "willothy/nvim-cokeline",
    dependencies = {
        "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
        "nvim-tree/nvim-web-devicons", -- If you want devicons
        "stevearc/resession.nvim"       -- Optional, for persistent history
    },
    config = function()
        require("cokeline").setup({
            default_hl = {
                bg = "NONE",
                fg = function(buffer)
                    return buffer.is_focused and '#FFFFFF'   -- your accent color (e.g. orange from Matugen)
                    or '#666666'                       -- very dim gray for inactive tabs
                end,

                -- Strong visual indicator for the selected tab (text only)
                bold = function(buffer) return buffer.is_focused end,

                -- Optional: add slight italic for extra distinction if you like
                italic = function(buffer) return buffer.is_focused end,
            },

            tabs = {
                placement = "right"
            },
            sidebar = {
                filetype = { "NvimTree", "neo-tree", "SidebarNvim", "Picker" },
                components = {},
            },
        })
    end
}
