local enabled = true
if enabled then
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
else
    return { }
end
