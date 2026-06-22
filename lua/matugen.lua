local M = {}

function M.setup()
    require("base16-colorscheme").setup({
        -- Background tones
        base00 = "#13121c", -- Default Background
        base01 = "#1f1f29", -- Lighter Background (status bars)
        base02 = "#2a2934", -- Selection Background
        base03 = "#918ea5", -- Comments, Invisibles
        -- Foreground tones
        base04 = "#c7c4dd", -- Dark Foreground (status bars)
        base05 = "#e4e0ef", -- Default Foreground
        base06 = "#e4e0ef", -- Light Foreground
        base07 = "#e4e0ef", -- Lightest Foreground
        -- Accent colors
        base08 = "#ffb4ab", -- Variables, XML Tags, Errors
        base09 = "#c3c0ff", -- Integers, Constants
        base0A = "#92cef5", -- Classes, Search Background
        base0B = "#83cfff", -- Strings, Diff Inserted
        base0C = "#c3c0ff", -- Regex, Escape Chars
        base0D = "#83cfff", -- Functions, Methods
        base0E = "#92cef5", -- Keywords, Storage
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
