local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#e0e1eb', -- Default Background
        base01 = '#d4d5e3', -- Lighter Background (status bars)
        base02 = '#cecedf', -- Selection Background
        base03 = '#8f92bc', -- Comments, Invisibles
        -- Foreground tones
        base04 = '#4c4c56', -- Dark Foreground (status bars)
        base05 = '#18181b', -- Default Foreground
        base06 = '#18181b', -- Light Foreground
        base07 = '#18181b', -- Lightest Foreground
        -- Accent colors
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#812d86', -- Integers, Constants
        base0A = '#542490', -- Classes, Search Background
        base0B = '#1b2299', -- Strings, Diff Inserted
        base0C = '#791b7e', -- Regex, Escape Chars
        base0D = '#171d82', -- Functions, Methods
        base0E = '#471b7e', -- Keywords, Storage
        base0F = '#f7bbc4', -- Deprecated, Embedded Tags
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
