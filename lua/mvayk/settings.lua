local tborder = "none"

if vim.g.neovide then
    tborder = "none"
end

return {
    border = tborder,
    theme_file = vim.fn.stdpath("data") .. "/last_theme.lua",
    transparent_background = false,
    use_matugen = false,
    neovide_transparency = false,
    neovide_animations = false,
    neovide_line_modes = false,
    icon_theme_package = "nvim-tree/nvim-web-devicons",
    --icon_theme_package = "nvim-tree/nvim-material-icon",
    use_base16_colorscheme = true,
    lsp_enabled = true,
    --lsp_system = "blink", --[[ blink, cmp ]]
    float_diagnostic = true,
}
