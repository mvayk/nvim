local M = {}

if require("settings").use_matugen then
    function M.setup()
        require("base16-colorscheme").setup({
            base00 = "#15131b",
            base01 = "#24202c",
            base02 = "#2e2938",
            base03 = "#665d7e",
            base04 = "#bfb3db",
            base05 = "#bfb3db",
            base06 = "#bfb3db",
            base07 = "#bfb3db",
            base08 = "#b87a87",
            base09 = "#5d507c",
            base0A = "#7866a3",
            base0B = "#9b8bc1",
            base0C = "#ae96e9",
            base0D = "#ae96e9",
            base0E = "#ae96e9",
            base0F = "#cebef4",
        })

        local hi = function(group, opts)
            vim.api.nvim_set_hl(0, group, opts)
        end

        -- telescope.nvim
        hi("TelescopeNormal", { fg = "#bfb3db", bg = "#15131b" })
        hi("TelescopeBorder", { fg = "#665d7e", bg = "#15131b" })
        hi("TelescopePromptNormal", { fg = "#bfb3db", bg = "#15131b" })
        hi("TelescopePromptBorder", { fg = "#665d7e", bg = "#15131b" })
        hi("TelescopePromptPrefix", { fg = "#9b8bc1", bg = "#15131b" })
        hi("TelescopePromptCounter", { fg = "#bfb3db", bg = "#15131b" })
        hi("TelescopePromptTitle", { fg = "#15131b", bg = "#9b8bc1" })
        hi("TelescopePreviewTitle", { fg = "#15131b", bg = "#7866a3" })
        hi("TelescopeResultsTitle", { fg = "#15131b", bg = "#5d507c" })
        hi("TelescopeSelection", { fg = "#bfb3db", bg = "#2e2938" })
        hi("TelescopeSelectionCaret", { fg = "#9b8bc1", bg = "#2e2938" })
        hi("TelescopeMatching", { fg = "#9b8bc1", bold = true })

        -- mini.pick
        hi("MiniPickNormal", { fg = "#bfb3db", bg = "#15131b" })
        hi("MiniPickBorder", { fg = "#665d7e", bg = "#15131b" })
        hi("MiniPickPrompt", { fg = "#bfb3db", bg = "#15131b" })
        hi("MiniPickPromptPrefix", { fg = "#9b8bc1", bg = "#15131b" })
        hi("MiniPickBorderText", { fg = "#15131b", bg = "#9b8bc1" })
        hi("MiniPickMatchCurrent", { fg = "#bfb3db", bg = "#2e2938" })
        hi("MiniPickPromptCaret", { fg = "#9b8bc1", bg = "#2e2938" })
        hi("MiniPickMatchRanges", { fg = "#9b8bc1", bold = true })
    end

    -- Register a signal handler for SIGUSR1 (matugen updates).
    -- The handler re-requires this module, which re-runs the code below, so the
    -- previous handle is stopped first; otherwise handlers double on every signal.
    if _G.__matugen_signal then
        _G.__matugen_signal:stop()
        _G.__matugen_signal:close()
    end

    local signal = vim.uv.new_signal()
    _G.__matugen_signal = signal
    signal:start(
        "sigusr1",
        vim.schedule_wrap(function()
            package.loaded["matugen"] = nil
            require("matugen").setup()
        end)
    )
end

return M
