return {
    "hedyhli/outline.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("outline").setup({
            vim.keymap.set("n", "go", "<cmd>Outline<CR>", { desc = "Toggle Outline" }),
        })
    end,
}
