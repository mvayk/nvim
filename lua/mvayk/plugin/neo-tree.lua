local enabled = false 

if enabled then
    return {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        lazy = false, -- neo-tree will lazily load itself
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
        },
        config = function()
            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

            require("neo-tree").setup({
                -- fill any relevant options here
                filesystem = {
                    filtered_items = {
                        visible = true,          -- ← this is the key: makes hidden files visible (but dimmed)
                        hide_dotfiles = false,   -- show files starting with .
                        hide_gitignored = false, -- also show gitignored files (change to true if you want to hide them)
                        show_hidden_count = true, -- shows "(X hidden)" at bottom if any
                        hide_by_name = {         -- force-hide specific ones if needed
                            ".git",
                        },
                        never_show = {           -- never ever show these
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                    hijack_netrw_behavior = "disabled",  -- ← crucial: let other plugins (Oil) handle dirs
                    -- rest of filesystem options...
                },

                window = {
                    position = "right",
                }
            })
        end
    }
else
    return { }
end
