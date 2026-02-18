local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        base00 = '#000000', -- Default Background
        base01 = '#000000', -- Lighter Background (status bars)
        base02 = '#3e1e1f', -- Selection Background
        base03 = '#756161', -- Comments, Invisibles
        base04 = '#b6afaf', -- Dark Foreground (status bars)
        base05 = '#f3f2f2', -- Default Foreground
        base06 = '#f3f2f2', -- Light Foreground
        base07 = '#f3f2f2', -- Lightest Foreground
        base08 = '#cb0c07', -- Variables, XML Tags, Errors
        base09 = '#e7e14b', -- Integers, Constants
        base0A = '#e7934b', -- Classes, Search Background
        base0B = '#ea6167', -- Strings, Diff Inserted
        base0C = '#f0ec8f', -- Regex, Escape Chars
        base0D = '#f08e93', -- Functions, Methods
        base0E = '#f0bb8f', -- Keywords, Storage
        base0F = '#4c0200', -- Deprecated, Embedded Tags
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
