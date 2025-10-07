local enabled = false

if enabled == true then
    return {
        "nvimdev/dashboard-nvim", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local dashboard = require("dashboard").setup({
                theme = 'hyper',
            })
        end
    }
else
    return { }
end
