-- oh for fuck sakes!
return {
    "folke/snacks.nvim",
    priority = 1000,  -- load early
    lazy = false,     -- important for picker/explorer availability
    opts = {
        dashboard = {
            enabled = false,
        },
        explorer = {
            enabled = false,
            replace_netrw = true,
            trash = true,
        },
        picker = {
            enabled = true,
            layout = {
                preset = "vscode",
            },
            position = "top",
            sources = {
                explorer = {
                    tree = true,
                    follow_file = false,
                    git_status = true,
                    hidden = true,
                    layout = {
                        layout = {
                            width = 0.2,
                            height = 1,
                            position = "right",
                        },
                    },
                },
                files = { hidden = true },  -- for regular file picker
                win = {
                    backdrop = false,
                },
            },
        },
    },
    keys = {
    },
}
