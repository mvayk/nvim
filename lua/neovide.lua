local M = {}

function M.setup()
    local settings = require("settings")

    if not vim.g.neovide then
        return
    end

    local default_font = "JetBrainsMono Nerd Font Mono:h16"
    vim.o.linespace = 4

    --vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_refresh_rate = 240
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 2
    vim.g.neovide_light_radius = 1
    vim.g.neovide_light_angle_degrees = 45

    vim.o.guicursor = "a:block-blinkon500-blinkoff500"
    vim.g.neovide_cursor_smooth_blink = true

    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true

    vim.o.guifont = default_font .. ":#e-subpixelantialias"

    vim.g.neovide_cursor_animation_length = 0.06 -- default 0.15; lower = snappier
    vim.g.neovide_cursor_trail_size = 0.4 -- default 0.7; shorter trail feels faster
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_short_animation_length = 0.04 -- for small moves (e.g. typing)

    -- Scrolling: smooth but quick
    vim.g.neovide_scroll_animation_length = 0.15 -- default 0.3
    vim.g.neovide_scroll_animation_far_lines = 1 -- animate even long jumps (set 0 to skip them)

    -- Window/split movement
    vim.g.neovide_position_animation_length = 0.1 -- default 0.15

    -- Optional: remove the cursor "vfx" if you want it clean
    vim.g.neovide_cursor_vfx_mode = "" -- or "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"

    if settings.neovide_ancient then
        vim.g.neovide_cursor_animate_in_insert_mode = false
        vim.g.neovide_cursor_animate_in_insert_mode = false
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

    if settings.neovide_animations and not settings.neovide_ancient then
        local fast = { length = 0.06, short = 0.04, trail = 0.4 }
        local slow = { length = 0.25, short = 0.12, trail = 0.8 }

        local function apply(p)
            vim.g.neovide_cursor_animation_length = p.length
            vim.g.neovide_cursor_short_animation_length = p.short
            vim.g.neovide_cursor_trail_size = p.trail
        end

        apply(fast)

        local group = vim.api.nvim_create_augroup("NeovideInsertCursor", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            group = group,
            callback = function()
                apply(slow)
            end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            group = group,
            callback = function()
                apply(fast)
            end,
        })
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
