local settings = require("mvayk.settings")
local M = {}

if settings.use_base16_colorscheme then
    function M.setup()
        require('base16-colorscheme').setup {
            base00 = '#000000', -- Default Background
            base01 = '#000000', -- Lighter Background (status bars)
            base02 = '#1e2f3e', -- Selection Background
            base03 = '#5f6a73', -- Comments, Invisibles
            base04 = '#afb3b6', -- Dark Foreground (status bars)
            base05 = '#f2f2f3', -- Default Foreground
            base06 = '#f2f2f3', -- Light Foreground
            base07 = '#f2f2f3', -- Lightest Foreground
            base08 = '#fd4663', -- Variables, XML Tags, Errors
            base09 = '#9566cc', -- Integers, Constants
            base0A = '#5c61d6', -- Classes, Search Background
            base0B = '#67abe4', -- Strings, Diff Inserted
            base0C = '#bc96e9', -- Regex, Escape Chars
            base0D = '#93c3ec', -- Functions, Methods
            base0E = '#9699e9', -- Keywords, Storage
            base0F = '#900017', -- Deprecated, Embedded Tags
        }
    end

    -- Register a signal handler for SIGUSR1 (matugen updates)
    local signal = vim.uv.new_signal()
    signal:start(
        'sigusr1',
        vim.schedule_wrap(function()
            package.loaded['matugen'] = nil
            require('matugen').setup()
        end)
    )

    return M
end
