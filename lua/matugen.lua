local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#131313', -- Default Background
        base01 = '#1f1f1f', -- Lighter Background (status bars)
        base02 = '#2a2a2a', -- Selection Background
        base03 = '#919191', -- Comments, Invisibles
        base04 = '#c6c6c6', -- Dark Foreground (status bars)
        base05 = '#e2e2e2', -- Default Foreground
        base06 = '#e2e2e2', -- Light Foreground
        base07 = '#e2e2e2', -- Lightest Foreground
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
