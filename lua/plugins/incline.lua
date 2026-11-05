local solarized_osaka = false

return {
    --[[ https://github.com/Fadilix/dotfiles/blob/main/nvim/lua/plugins/ui.lua ]]
    "b0o/incline.nvim",
    enabled = true,
    dependencies = {
        "craftzdog/solarized-osaka.nvim",
        {
            require("settings").icon_theme_package.git,
            lazy = false,
        },
    },
    event = "BufReadPre",
    priority = 1200,

    config = function()
        -- .git is the repo string for lazy.nvim, .name is the actual module name
        local function get_icon(filename)
            local ok, devicons = pcall(require, require("settings").icon_theme_package.name)
            if ok then
                local icon, color = devicons.get_icon_color(filename, nil, { default = true })
                return icon, { guifg = color }
            end

            return "", {}
        end

        local opts = {
            window = {
                margin = { vertical = 2, horizontal = 2 },
                width = "fit",
                padding = 1,
            },
            hide = { cursorline = true },
            render = function(props)
                local name = vim.api.nvim_buf_get_name(props.buf)
                local filename = vim.fn.fnamemodify(name, ":t")
                if filename == "" then
                    filename = "[No Name]"
                end

                local icon, icon_hl = get_icon(filename)

                local icon_part = { icon .. " " }
                for k, v in pairs(icon_hl) do
                    icon_part[k] = v
                end

                return { icon_part, { filename } }
            end,
        }

        if solarized_osaka then
            local colors = require("solarized-osaka.colors").setup()
            opts.highlight = {
                groups = {
                    InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
                    InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
                },
            }
        end

        require("incline").setup(opts)
    end,
}
