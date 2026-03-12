return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    show_hidden_count = true,
                    hide_by_name = {
                        ".git",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
                hijack_netrw_behavior = "disabled",
            },
            source_selector = {
                winbar = false, -- toggle to show selector on winbar
                statusline = false, -- toggle to show selector on statusline
            },
            window = {
                position = "right",
            },
        })
    end,
}
