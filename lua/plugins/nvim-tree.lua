return {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    version = "*",
    lazy = false,
    dependencies = {
        require("settings").icon_theme_package.git,
    },
    config = function()
        vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Open NvimTree" })
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
                side = "right",
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = true,
                        git = false,
                        modified = false,
                        diagnostics = false,
                        bookmarks = false,
                    },
                },
            },
            filters = {
                dotfiles = false,
            },
        })
    end,
}
