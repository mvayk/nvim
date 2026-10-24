return {
    {
        dir = vim.fn.stdpath("config"),
        name = "project-outline",
        dependencies = { "folke/snacks.nvim" },
        keys = {
            {
                "<leader>fo",
                function()
                    require("project_outline").pick()
                end,
                desc = "Project outline",
            },
        },
        config = function()
            require("project_outline").setup()
        end,
    },
}
