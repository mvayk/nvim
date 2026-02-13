local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#f9f9f9', -- Default Background
        base01 = '#eeeeee', -- Lighter Background (status bars)
        base02 = '#e8e8e8', -- Selection Background
        base03 = '#777777', -- Comments, Invisibles
        -- Foreground tones
        base04 = '#474747', -- Dark Foreground (status bars)
        base05 = '#1b1b1b', -- Default Foreground
        base06 = '#1b1b1b', -- Light Foreground
        base07 = '#1b1b1b', -- Lightest Foreground
        -- Accent colors
        base08 = '#ba1a1a', -- Variables, XML Tags, Errors
        base09 = '#7d5261', -- Integers, Constants
        base0A = '#615b71', -- Classes, Search Background
        base0B = '#6550a5', -- Strings, Diff Inserted
        base0C = '#efb8c9', -- Regex, Escape Chars
        base0D = '#cdbdff', -- Functions, Methods
        base0E = '#cbc3dc', -- Keywords, Storage
        base0F = '#ffdad6', -- Deprecated, Embedded Tags
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
