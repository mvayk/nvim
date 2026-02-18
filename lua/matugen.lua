local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#211c1c', -- Default Background
        base01 = '#372f2f', -- Lighter Background (status bars)
        base02 = '#322a2a', -- Selection Background
        base03 = '#6f6666', -- Comments, Invisibles
        base04 = '#b5b0b0', -- Dark Foreground (status bars)
        base05 = '#f3f2f2', -- Default Foreground
        base06 = '#f3f2f2', -- Light Foreground
        base07 = '#f3f2f2', -- Lightest Foreground
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#999999', -- Integers, Constants
        base0A = '#999999', -- Classes, Search Background
        base0B = '#a6a6a6', -- Strings, Diff Inserted
        base0C = '#bfbfbf', -- Regex, Escape Chars
        base0D = '#bfbfbf', -- Functions, Methods
        base0E = '#bfbfbf', -- Keywords, Storage
        base0F = '#533d41', -- Deprecated, Embedded Tags
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
