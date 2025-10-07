local enabled = false

if enabled then
    return {
        'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
            })
        end
    }
else
    return { }
end
