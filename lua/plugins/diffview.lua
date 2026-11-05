return {
    "sindrets/diffview.nvim",
    enabled = true,
    lazy = true,
    config = function()
        require("diffview").setup({
            vim.keymap.set("n", "<leader>gn", ":DiffviewOpen<CR>", { desc = "Git Diff" }),
            vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { desc = "Git Diff" }),
            vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "File History" }),
        })
    end,
}
