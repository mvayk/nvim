return {
    "luukvbaal/nnn.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("nnn").setup({})
        vim.keymap.set("n", "<leader>n", ":NnnPicker<CR>", { noremap = true, silent = true })
    end,
}
