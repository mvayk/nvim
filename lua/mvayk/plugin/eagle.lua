return {
    "soulis-1256/eagle.nvim",
    opts = {
        keyboard_mode = true,
    },
    config = function(_, opts)
        require("eagle").setup(opts)
        vim.o.mousemoveevent = true
        vim.keymap.set("n", "<leader>", ":EagleWin<CR>", { noremap = true, silent = true })
    end,
}
