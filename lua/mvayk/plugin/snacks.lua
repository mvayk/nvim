-- oh for fuck sakes!
return {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000, -- load early
    lazy = true, -- important for picker/explorer availability
    opts = {
        dashboard = {
            enabled = true,
            sections = {
                { padding = 1 },
                { section = "header" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        explorer = {
            enabled = false,
            replace_netrw = true,
            trash = true,
        },
        picker = {
            enabled = true,
            preview = true,
            layout = {
                preset = "ivy",
                layout = {
                    position = "top",
                },
            },
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
                files = { hidden = true }, -- for regular file picker
                win = {
                    backdrop = false,
                },
            },
        },
    },
    keys = {},
}
