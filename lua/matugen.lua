local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#000000', -- Default Background
        base01 = '#000000', -- Lighter Background (status bars)
        base02 = '#0b1f50', -- Selection Background
        base03 = '#5e6472', -- Comments, Invisibles
        base04 = '#afb1b6', -- Dark Foreground (status bars)
        base05 = '#f2f2f3', -- Default Foreground
        base06 = '#f2f2f3', -- Light Foreground
        base07 = '#f2f2f3', -- Lightest Foreground
        base08 = '#fd4663', -- Variables, XML Tags, Errors
        base09 = '#ba4ae8', -- Integers, Constants
        base0A = '#6b4ae8', -- Classes, Search Background
        base0B = '#6189eb', -- Strings, Diff Inserted
        base0C = '#d48ef1', -- Regex, Escape Chars
        base0D = '#8eaaf1', -- Functions, Methods
        base0E = '#a28ef1', -- Keywords, Storage
        base0F = '#900017', -- Deprecated, Embedded Tags
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
