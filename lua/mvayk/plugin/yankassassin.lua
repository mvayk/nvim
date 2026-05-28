return {
    "svban/YankAssassin.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("YankAssassin").setup({
            auto_normal = true,
            auto_visual = true,
        })
        vim.keymap.set({ "x", "n" }, "gy", "<Plug>(YADefault)", { silent = true })
        --vim.keymap.set({ "x", "n" }, "<leader>y", "<Plug>(YANoMove)", { silent = true })
        vim.keymap.set({ "x", "n" }, "y", "<Plug>(YANoMove)", { silent = true })
    end,
}
