local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#e0e6eb', -- Default Background
        base01 = '#d3dde3', -- Lighter Background (status bars)
        base02 = '#cdd8df', -- Selection Background
        base03 = '#6387a2', -- Comments, Invisibles
        base04 = '#505458', -- Dark Foreground (status bars)
        base05 = '#181a1b', -- Default Foreground
        base06 = '#181a1b', -- Light Foreground
        base07 = '#181a1b', -- Lightest Foreground
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#522d86', -- Integers, Constants
        base0A = '#2931a3', -- Classes, Search Background
        base0B = '#227fc3', -- Strings, Diff Inserted
        base0C = '#441b7e', -- Regex, Escape Chars
        base0D = '#175582', -- Functions, Methods
        base0E = '#1b217e', -- Keywords, Storage
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
