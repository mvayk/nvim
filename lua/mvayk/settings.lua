local tborder = "none"

if vim.g.neovide then
    tborder = "rounded"
end

return {
    border = tborder,
    theme_file = vim.fn.stdpath("data") .. "/last_theme.lua",
    transparent_background = true,
    neovide_transparency = false,
    neovide_animations = false,
    icon_theme_package = "nvim-web-devicons",
    --icon_theme_package = "nvim-material-icon",
    use_base16_colorscheme = false,
    lsp_system = "blink", --[[ blink, cmp ]]
    float_diagnostic = false,
}
