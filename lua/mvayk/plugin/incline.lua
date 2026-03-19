local solarized_osaka = false
return {
    --[[ https://github.com/Fadilix/dotfiles/blob/main/nvim/lua/plugins/ui.lua ]]
    "b0o/incline.nvim",
    enabled = true,
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
        if solarized_osaka then
            local colors = require("solarized-osaka.colors").setup()
            require("incline").setup({
                highlight = {
                    groups = {
                        InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
                        InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
                    },
                },
                window = { margin = { vertical = 0, horizontal = 0 } },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if vim.bo[props.buf].modified then
                        filename = "[+] " .. filename
                    end

                    local icon, color = require("lua.mvayk.plugin.icons-theme").get_icon_color(filename)
                    return { { icon, guifg = color }, { " " }, { filename } }
                end,
            })
        else
            require("incline").setup({
                window = { margin = { vertical = 0, horizontal = 0 } },
                hide = {
                    cursorline = false,
                },
            })
        end
    end,
}
