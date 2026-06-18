local M = {}

function M.setup()
    require("base16-colorscheme").setup({
        -- Background tones
        base00 = "#15121c", -- Default Background
        base01 = "#211e28", -- Lighter Background (status bars)
        base02 = "#2c2833", -- Selection Background
        base03 = "#958da1", -- Comments, Invisibles
        -- Foreground tones
        base04 = "#ccc3d8", -- Dark Foreground (status bars)
        base05 = "#e8dfee", -- Default Foreground
        base06 = "#e8dfee", -- Light Foreground
        base07 = "#e8dfee", -- Lightest Foreground
        -- Accent colors
        base08 = "#ffb4ab", -- Variables, XML Tags, Errors
        base09 = "#ffade4", -- Integers, Constants
        base0A = "#d2bcff", -- Classes, Search Background
        base0B = "#d2bcff", -- Strings, Diff Inserted
        base0C = "#ffade4", -- Regex, Escape Chars
        base0D = "#d2bcff", -- Functions, Methods
        base0E = "#d2bcff", -- Keywords, Storage
        base0F = "#93000a", -- Deprecated, Embedded Tags
    })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
    "sigusr1",
    vim.schedule_wrap(function()
        package.loaded["matugen"] = nil
        require("matugen").setup()
    end)
)

return M
