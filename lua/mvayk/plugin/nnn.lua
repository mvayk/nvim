return {
    "luukvbaal/nnn.nvim",
    enabled = true,
    config = function()
        require("nnn").setup({})
        vim.keymap.set("n", "<leader>n", ":NnnPicker<CR>", { noremap = true, silent = true })
    end,
}
