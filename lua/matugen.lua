local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#121316', -- Default Background
        base01 = '#1e2022', -- Lighter Background (status bars)
        base02 = '#292a2d', -- Selection Background
        base03 = '#8d9199', -- Comments, Invisibles
        base04 = '#c3c6cf', -- Dark Foreground (status bars)
        base05 = '#e3e2e6', -- Default Foreground
        base06 = '#e3e2e6', -- Light Foreground
        base07 = '#e3e2e6', -- Lightest Foreground
        base08 = '#ffb4ab', -- Variables, XML Tags, Errors
        base09 = '#d7bde4', -- Integers, Constants
        base0A = '#bbc7db', -- Classes, Search Background
        base0B = '#a0c9ff', -- Strings, Diff Inserted
        base0C = '#d7bde4', -- Regex, Escape Chars
        base0D = '#a0c9ff', -- Functions, Methods
        base0E = '#bbc7db', -- Keywords, Storage
        base0F = '#93000a', -- Deprecated, Embedded Tags
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
