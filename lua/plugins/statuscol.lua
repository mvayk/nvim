return {
    "luukvbaal/statuscol.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
        local builtin = require("statuscol.builtin")

        require("statuscol").setup({
            relculright = true,
            ft_ignore = { "neo-tree", "NvimTree" },
            bt_ignore = { "terminal", "nofile", "prompt" },
            segments = {
                { text = { "1", maxwidth = 1 } },
                { sign = { namespace = { ".*diagnostic.*" }, maxwidth = 1 } },
                { text = { builtin.lnumfunc, " " } },
            },
        })

        local groups = {
            "SignColumn",
            "CursorLineSign",
            "FoldColumn",
            "CursorLineFold",
            "DiagnosticSignError",
            "DiagnosticSignWarn",
            "DiagnosticSignInfo",
            "DiagnosticSignHint",
            "DiagnosticSignOk",
        }

        local function clear_column_bg()
            for _, name in ipairs(groups) do
                local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
                if ok and hl then
                    hl.bg = nil
                    hl.ctermbg = nil
                    vim.api.nvim_set_hl(0, name, hl)
                end
            end
        end

        clear_column_bg()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("StatuscolClearBg", { clear = true }),
            callback = clear_column_bg,
        })
    end,
}
