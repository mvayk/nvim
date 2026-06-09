local settings = require("mvayk.settings")

if not vim.g.neovide then
    return
end

--[[
SpaceMono Nerd Font Mono:h17
BigBlueTermPlus Nerd Font Mono:h15
VictorMono Nerd Font Mono:h15
]]
local default_font = "JetBrainsMono Nerd Font Mono:h19"
vim.o.guifont = default_font
vim.o.linespace = 0

settings.transparent_background = settings.neovide_transparency

if not settings.neovide_animations then
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_scroll_animation_length = 0.00
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
end

if settings.neovide_transparency then
    vim.g.neovide_opacity = 0.7
end

--[[ vim.g.neovide_padding_top = 16
vim.g.neovide_padding_bottom = 16
vim.g.neovide_padding_left = 20
vim.g.neovide_padding_right = 20 ]]

local function change_font_size(delta)
    local font = vim.o.guifont
    local name = font:match("(.+:h)%d+")
    local size = tonumber(font:match(":h(%d+)"))
    local new_size = math.max(6, size + delta)
    vim.o.guifont = name .. new_size
end

vim.keymap.set("n", "<C-=>", function()
    change_font_size(1)
end)
vim.keymap.set("n", "<C-->", function()
    change_font_size(-1)
end)
vim.keymap.set("n", "<C-0>", function()
    vim.o.guifont = "VictorMono Nerd Font Mono:h15"
end)
