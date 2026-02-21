local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#ffffff', -- Default Background
        base01 = '#ffffff', -- Lighter Background (status bars)
        base02 = '#c8d7e4', -- Selection Background
        base03 = '#6487a3', -- Comments, Invisibles
        base04 = '#4f5357', -- Dark Foreground (status bars)
        base05 = '#181a1b', -- Default Foreground
        base06 = '#181a1b', -- Light Foreground
        base07 = '#181a1b', -- Lightest Foreground
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#562d86', -- Integers, Constants
        base0A = '#292ea3', -- Classes, Search Background
        base0B = '#2070b4', -- Strings, Diff Inserted
        base0C = '#491b7e', -- Regex, Escape Chars
        base0D = '#175182', -- Functions, Methods
        base0E = '#1b1f7e', -- Keywords, Storage
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
