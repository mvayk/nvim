return {
    "hedyhli/outline.nvim",
    config = function()
        require("outline").setup({
            vim.keymap.set("n", "go", "<cmd>Outline<CR>", { desc = "Toggle Outline" }),
        })
    end,
}
