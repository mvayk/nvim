return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>ft",
            function()
                Snacks.picker.todo_comments()
            end,
            desc = "Find todos",
        },
    },
}
