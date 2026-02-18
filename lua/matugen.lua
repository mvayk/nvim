local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#e6e6e6', -- Default Background
        base01 = '#dbdbdb', -- Lighter Background (status bars)
        base02 = '#d6d6d6', -- Selection Background
        base03 = '#8e8181', -- Comments, Invisibles
        base04 = '#575252', -- Dark Foreground (status bars)
        base05 = '#1a1919', -- Default Foreground
        base06 = '#1a1919', -- Light Foreground
        base07 = '#1a1919', -- Lightest Foreground
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#0d0d0d', -- Integers, Constants
        base0A = '#0d0d0d', -- Classes, Search Background
        base0B = '#0d0d0d', -- Strings, Diff Inserted
        base0C = '#4c4c4c', -- Regex, Escape Chars
        base0D = '#4c4c4c', -- Functions, Methods
        base0E = '#4c4c4c', -- Keywords, Storage
        base0F = '#fcb5c0', -- Deprecated, Embedded Tags
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
