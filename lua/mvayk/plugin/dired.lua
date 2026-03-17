return {
    "X3eRo0/dired.nvim",
    enabled = true,
    requires = "MunifTanjim/nui.nvim",
    config = function()
        require("dired").setup({
            path_separator = "/",
            show_banner = false,
            show_icons = true,
            show_hidden = true,
            show_dot_dirs = true,
            show_colors = true,

            keybinds = {
                keybinds = {
                    dired_enter = "<CR>",
                    dired_back = "-",
                    dired_up = "_",
                    dired_rename = "R",
                    dired_quit = "q",
                },
            },
        })
    end,
}
