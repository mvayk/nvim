local tborder = "none"

if vim.g.neovide then
    tborder = "single"
end

return {
    border = tborder,
    theme_file = vim.fn.stdpath("data") .. "/last_theme.lua",
    transparent_background = false,
    neovide_transparency = false,
    neovide_animations = false,
    neovide_line_modes = false,
    icon_theme_package = "nvim-web-devicons",
    --icon_theme_package = "nvim-material-icon",
    use_base16_colorscheme = true,
    lsp_enabled = true,
    --lsp_system = "blink", --[[ blink, cmp ]]
    float_diagnostic = false,
}
