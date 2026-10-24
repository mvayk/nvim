return {
    "barklan/capslock.nvim",
    enabled = false,
    lazy = true,
    keys = {
        { "<C-l>", "<Plug>CapsLockToggle", mode = { "i", "c" } },
        { "<leader>c", "<Plug>CapsLockToggle", mode = { "n" } },
    },
    config = true,
}
