local enabled = true
if enabled then
    return {
        "svban/YankAssassin.nvim",
        event = "VeryLazy",
        opts = {
            auto = true,
            maintainCursor = true
        }
    }
else
    return { }
end
