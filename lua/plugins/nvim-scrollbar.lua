local enabled = vim.g.neovide
if enabled then
    return {
        "petertriho/nvim-scrollbar",
        enabled = false,
        lazy = false,
        event = "VeryLazy",
        config = function()
            require("scrollbar").setup({})
        end,
    }
else
    return {}
end
