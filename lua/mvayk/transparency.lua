local function anti_background()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "FoldColumn",
        "EndOfBuffer",
        "DiagnosticSignError",
        "DiagnosticSignWarn",
        "DiagnosticSignInfo",
        "DiagnosticSignHint",
        "LspCodeActionSign",

        "FloatBorder",
        -- "Pmenu",
        -- "PmenuSel",
        -- "PmenuSbar",
        -- "PmenuThumb",
        "WinSeparator",
        "StatusLine",
        "StatusLineNC",

        --[[ "lualine_a_normal",
            "lualine_b_normal",
            "lualine_c_normal",
            "lualine_x_normal",
            "lualine_y_normal",
            "lualine_z_normal",
            "lualine_a_insert",
            "lualine_b_insert",
            "lualine_c_insert",
            "lualine_x_insert",
            "lualine_y_insert",
            "lualine_z_insert", ]]

        "SnacksPicker",
        "SnacksPickerBorder",
        "SnacksPickerTitle",
        "SnacksPickerInput",
        "SnacksPickerList",
        "SnacksPickerPreview",
        "SnacksPickerPrompt",
        "SnacksPickerDir",
        "SnacksPickerMatch",
        "SnacksPickerIcon",
        --"SnacksPickerCursorLine",
        --"SnacksPickerListCursorLine",
        "SnacksDashboard",
        "SnacksDashboardIcon",
        "SnacksDashboardDesc",
        "SnacksDashboardKey",
        "SnacksDashboardTitle",

        "SnacksNotifierInfo",
        "SnacksNotifierWarn",
        "SnacksNotifierError",
        "SnacksNotifierDebug",
        "SnacksNotifierTrace",
        "SnacksNotifierBorder",

        "DropBarHover",
        "DropBarCurrentContext",
        "DropBarMenuCurrentContext",
        "DropBarMenuFloatBorder",
        "DropBarMenuHoverEntry",
        "DropBarMenuHoverIcon",
        "DropBarMenuHoverSymbol",
        "DropBarMenuSbar",

        "CursorLine",
        "ColorColumn",
        "Folded",
        "VertSplit",
        "TabLine",
        "TabLineFill",
        "TabLineSel",
        "MsgArea",
        "WinBar",
        "WinBarNC",
        "NormalSB",
        "TelescopeNormal",
        "TelescopeBorder",
        "NeoTreeStatusLine",
        "NeoTreeStatusLineNC",
        "SnacksNormal",
        "SnacksNormalNC",
        "SnacksWinBar",
        "LualineNormal",

        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeFloatBorder",
        "NeoTreeTitleBar",
        "NeoTreeWinSeparator",
        "NeoTreeFileName",
        "NeoTreeDirectoryName",
        "NeoTreeRootName",
        "NeoTreeGitUntracked",
        "NeoTreeGitModified",

        "NeoTreeTabInactive",
        "NeoTreeTabActive",
        "NeoTreeTabInactive",
        "NeoTreeTabSeparatorInactive",
        "NeoTreeTabSeparatorActive",
    }

    for _, group in ipairs(groups) do
        -- local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        -- hl.bg, hl.ctermbg = nil, nil
        --
        -- vim.api.nvim_set_hl(0, group, hl)
        local g = group
        vim.cmd(("hi %s guibg=NONE ctermbg=NONE"):format(g))
    end

    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#cccccc" })

    vim.api.nvim_set_hl(0, "IblScope", { link = "LineNr" })

    if require("mvayk.plugin.neo-tree").enabled then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "neo-tree",
            callback = function()
                vim.schedule(anti_background)
            end,
        })
    end

    -- nixos shenanigans cause this to be undercurled for some reason probably
    --vim.api.nvim_set_hl(0, "@lsp.type.unresolvedReference", { undercurl = false })
end

return anti_background
