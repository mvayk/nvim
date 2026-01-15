return {
    "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo = require("todo-comments")
        local Snacks = require("snacks")
        todo.setup({
            keys = {
                { "gct", function() Snacks.picker.todo_comments() end, desc = "Todo" },
                { "gcT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
            },
        })
    end
}
