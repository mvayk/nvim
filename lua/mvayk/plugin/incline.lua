local solarized_osaka = false
return {
    --[[ https://github.com/Fadilix/dotfiles/blob/main/nvim/lua/plugins/ui.lua ]]
    "b0o/incline.nvim",
    enabled = true,
    dependencies = {
        "craftzdog/solarized-osaka.nvim",
        {
            require("mvayk.settings").icon_theme_package,
            lazy = false,
        }
    },
    event = "BufReadPre",
    priority = 1200,
    config = function()
        local opts = {
            window = { margin = { vertical = 2, horizontal = 2 } },
            hide = { cursorline = true },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                -- if vim.bo[props.buf].modified then
                --     filename = "[+] " .. filename
                -- end
                local ok, devicons = pcall(require, require("mvayk.settings").icon_theme_package)
                local icon, color = "", nil
                if ok then icon, color = devicons.get_icon_color(filename) end
                return { { icon, guifg = color }, { " " }, { filename } }
            end,
        }

        if solarized_osaka then
            local colors = require("solarized-osaka.colors").setup()
            opts.highlight = {
                groups = {
                    InclineNormal   = { guibg = colors.magenta500, guifg = colors.base04 },
                    InclineNormalNC = { guifg = colors.violet500,  guibg = colors.base03 },
                },
            }
        end

        require("incline").setup(opts)
    end,
}
