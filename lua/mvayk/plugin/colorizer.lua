local enabled=  false
if enabled then
    return {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end
    }
else
    return { }
end
