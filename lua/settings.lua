local tborder = "none"

if vim.g.neovide then
    tborder = "none"
end

local M = {}

local mini_icons = {
    name = "mini.icons",
    git = "nvim-mini/mini.icons",
    conf = function()
        if M.neovide_ancient then
            return { style = "ascii" } -- or "ascii" for plain letters
        end
        return {}
    end,
    setup = function(self)
        require("mini.icons").setup(self.conf())
        require("mini.icons").mock_nvim_web_devicons()
    end,
}

local web_icons = {
    name = "nvim-web-devicons",
    git = "nvim-tree/nvim-web-devicons",
    conf = {},
    setup = function(self)
        require("nvim-web-devicons").setup(self.conf)
    end,
}

M = {
    border = tborder,
    theme_file = vim.fn.stdpath("data") .. "/last_theme.lua",
    transparent_background = true,
    use_matugen = false,

    neovide_transparency = true,
    neovide_animations = true,
    neovide_line_modes = true,
    neovide_ancient = false,

    icon_theme_package = web_icons,

    lsp_enabled = true,
    --lsp_system = "blink", --[[ blink, cmp ]]
    show_blink_documentation = true,
    float_diagnostic = false,
    understyle = "undercurl", --"underline" | "undercurl" | "underdotted" | "underdashed" | "underdouble" | "none"
}

function M.get_glyphs()
    local glyphs = {
        error = "",
        warn = "",
        info = "",
        hint = "",
    }

    if M.neovide_ancient and vim.g.neovide then
        glyphs = {
            error = "X",
            warn = "!",
            info = "i",
            hint = "?",
        }
    end

    if not vim.g.neovide then
        glyphs = {
            error = "E",
            warn = "W",
            info = "I",
            hint = "H",
        }
    end

    return glyphs
end

M.icon_theme_package = M.neovide_ancient and mini_icons or web_icons
M.understyle = M.neovide_ancient and "undercurl" or "underline" -- gets overwritten anyway lel

return M
