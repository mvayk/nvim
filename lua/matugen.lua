local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#131311', -- Default Background
        base01 = '#20201d', -- Lighter Background (status bars)
        base02 = '#2b2b28', -- Selection Background
        base03 = '#929287', -- Comments, Invisibles
        -- Foreground tones
        base04 = '#c9c8bc', -- Dark Foreground (status bars)
        base05 = '#e6e3df', -- Default Foreground
        base06 = '#e6e3df', -- Light Foreground
        base07 = '#e6e3df', -- Lightest Foreground
        -- Accent colors
        base08 = '#ffaa97', -- Variables, XML Tags, Errors
        base09 = '#bfcac6', -- Integers, Constants
        base0A = '#c8c9b8', -- Classes, Search Background
        base0B = '#c6cba7', -- Strings, Diff Inserted
        base0C = '#bfcac6', -- Regex, Escape Chars
        base0D = '#c6cba7', -- Functions, Methods
        base0E = '#c8c9b8', -- Keywords, Storage
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
