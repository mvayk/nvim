local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#131315', -- Default Background
        base01 = '#212023', -- Lighter Background (status bars)
        base02 = '#2b2a2d', -- Selection Background
        base03 = '#92919a', -- Comments, Invisibles
        -- Foreground tones
        base04 = '#c9c6d0', -- Dark Foreground (status bars)
        base05 = '#e5e2e6', -- Default Foreground
        base06 = '#e5e2e6', -- Light Foreground
        base07 = '#e5e2e6', -- Lightest Foreground
        -- Accent colors
        base08 = '#ffaa97', -- Variables, XML Tags, Errors
        base09 = '#dac1ce', -- Integers, Constants
        base0A = '#c7c6d9', -- Classes, Search Background
        base0B = '#c3c4ef', -- Strings, Diff Inserted
        base0C = '#dac1ce', -- Regex, Escape Chars
        base0D = '#c3c4ef', -- Functions, Methods
        base0E = '#c7c6d9', -- Keywords, Storage
        base0F = '#950004', -- Deprecated, Embedded Tags
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
