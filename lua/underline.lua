local M = {}

local targets = {
    DiagnosticUnderlineError = "DiagnosticError",
    DiagnosticUnderlineWarn = "DiagnosticWarn",
    DiagnosticUnderlineInfo = "DiagnosticInfo",
    DiagnosticUnderlineHint = "DiagnosticHint",
    DiagnosticUnderlineOk = "DiagnosticOk",
    SpellBad = "DiagnosticError",
    SpellCap = "DiagnosticWarn",
    SpellLocal = "DiagnosticInfo",
    SpellRare = "DiagnosticHint",
}

local all_styles = { "underline", "undercurl", "underdotted", "underdashed", "underdouble" }

local function get(name)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    return (ok and hl) or {}
end

function M.apply()
    local style = require("settings").understyle or "underline"

    vim.diagnostic.config({ underline = style ~= "none" })

    for group, color_from in pairs(targets) do
        local hl = get(group)
        local sp = hl.sp or hl.fg or get(color_from).fg

        for _, s in ipairs(all_styles) do
            hl[s] = nil
        end

        if style ~= "none" then
            hl[style] = true
            hl.sp = sp
        end

        vim.api.nvim_set_hl(0, group, hl)
    end
end

return M
