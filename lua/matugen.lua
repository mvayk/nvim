local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#141316', -- Default Background
        base01 = '#201f23', -- Lighter Background (status bars)
        base02 = '#2b292d', -- Selection Background
        base03 = '#938f99', -- Comments, Invisibles
        base04 = '#c9c4d0', -- Dark Foreground (status bars)
        base05 = '#e6e1e6', -- Default Foreground
        base06 = '#e6e1e6', -- Light Foreground
        base07 = '#e6e1e6', -- Lightest Foreground
        base08 = '#ffb4ab', -- Variables, XML Tags, Errors
        base09 = '#edb8cc', -- Integers, Constants
        base0A = '#c9c3dc', -- Classes, Search Background
        base0B = '#cabeff', -- Strings, Diff Inserted
        base0C = '#edb8cc', -- Regex, Escape Chars
        base0D = '#cabeff', -- Functions, Methods
        base0E = '#c9c3dc', -- Keywords, Storage
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
