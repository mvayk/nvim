return {
    "shortcuts/no-neck-pain.nvim",
    enabled = false,
    lazy = false,
    config = function()
        require("no-neck-pain").setup({
            width = 120,
            mappings = { enabled = true },
            autocmds = { enableOnVimEnter = true },
        })
    end,
}
