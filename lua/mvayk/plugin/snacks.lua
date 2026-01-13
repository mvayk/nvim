-- oh for fuck sakes!
return {
    "folke/snacks.nvim",
    priority = 1000,  -- load early
    lazy = false,     -- important for picker/explorer availability
    opts = {
        dashboard = {
            enabled = false,
        },
        picker = {
            enabled = true,
            -- Optional: customize sources, layouts, etc.
            sources = {
                explorer = {
                    hidden = true,          -- show hidden files by default
                    tree = true,            -- tree view
                    follow_file = true,     -- follow current file
                    git_status = true,
                },
                files = { hidden = true },  -- for regular file picker
                win = {
                    backdrop = false,
                },
            },
            -- Layout presets (e.g. telescope-like)
            layouts = {
                telescope = {  -- optional: mimic Telescope look
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        width = 0.8,
                        height = 0.9,
                        border = "none",
                        -- ... more tweaks if needed
                    },
                },
            },
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
    },
    keys = {
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Git Files" },
        { "<leader>/",  function() Snacks.picker.grep() end,     desc = "Live Grep" },

        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },

        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    },
}
