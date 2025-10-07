return {
    "luukvbaal/nnn.nvim",
    config = function()
        require("nnn").setup({})
        vim.keymap.set('n', '<leader>n', ':NnnPicker<CR>', { noremap = true, silent = true })
    end
}
