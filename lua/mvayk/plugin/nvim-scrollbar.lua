local enabled = false;
if enabled then
    return {
        "petertriho/nvim-scrollbar",

        config = function()
            require("scrollbar").setup({})
        end
    }
else
    return { }
end
