return {
    "sindrets/diffview.nvim",
    enabled = false,
    lazy = true,
    config = function()
        require("diffview").setup({
            vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git Diff" }),
            vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { desc = "Git Diff" }),
            vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "File History" }),
        })
    end,
}
