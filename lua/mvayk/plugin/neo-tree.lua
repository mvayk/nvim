local enabled = true

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
