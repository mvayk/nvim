local M = {}

function M.setup()
    local settings = require("settings")

    if not vim.g.neovide then
        return
    end

    local default_font = "Inconsolata Nerd Font Mono:h16"
    vim.o.linespace = 4

    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_refresh_rate = 240
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 2
    vim.g.neovide_light_radius = 1
    vim.g.neovide_light_angle_degrees = 45

    vim.o.guicursor = "n-v-c:block-blinkon500-blinkoff500,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20"
    vim.g.neovide_cursor_smooth_blink = true

    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false

    vim.o.guifont = default_font .. ":#e-subpixelantialias"

    if settings.neovide_ancient then
        default_font = "Fixedsys Excelsior 3.01:h16:#e-alias:#h-full"
        vim.o.linespace = 0
        vim.g.neovide_scale_factor = 1.0

        settings.neovide_animations = false
        vim.g.neovide_cursor_vfx_mode = "none"

        vim.g.neovide_floating_corner_radius = 0.0
        vim.g.neovide_floating_shadow = false
        vim.g.neovide_floating_z_height = 10
        vim.g.neovide_light_angle_degrees = 45
        vim.g.neovide_light_radius = 5

        vim.g.neovide_progress_bar_enabled = false
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_cursor_antialiasing = false
        vim.g.neovide_pixel_geometry = "RGBV"

        vim.g.neovide_opacity = 1.0
        vim.g.neovide_floating_blur_amount_x = 0.0
        vim.g.neovide_floating_blur_amount_y = 0.0
        vim.g.neovide_scroll_animation_length = 0
        vim.g.neovide_scroll_animation_far_lines = 0
        vim.g.neovide_cursor_smooth_blink = false

        vim.o.cursorline = true
        vim.o.winbar = " File  Edit  Search  View  Help"

        vim.cmd.colorscheme("win95")
        vim.o.guifont = default_font
        require("lualine.win95").setup()
    end

    vim.g.neovide_pixel_geometry = "RGBH"

    settings.transparent_background = settings.neovide_transparency
    if not settings.neovide_animations or settings.neovide_ancient then
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

    local function change_font_size(delta)
        local font = vim.o.guifont
        local size = tonumber(font:match(":h(%d+)"))
        local new_size = math.max(6, size + delta)
        vim.o.guifont = font:gsub(":h%d+", ":h" .. new_size)
    end

    vim.keymap.set("n", "<C-=>", function()
        change_font_size(1)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_font_size(-1)
    end)
end

return M
