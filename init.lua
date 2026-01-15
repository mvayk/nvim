require("mvayk")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    import = "mvayk.plugin",
})

local function other_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })

    vim.api.nvim_set_hl(0, 'TabLineFill', { link = "NONE" })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = "NONE" })

    vim.api.nvim_set_hl(0, "SignColumn",      { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineSign",  { bg = "NONE", ctermbg = "NONE" })  -- important when cursorline is on
    vim.api.nvim_set_hl(0, "FoldColumn",       { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr",           { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr",     { bg = "NONE", ctermbg = "NONE" }) -- line number of cursor line
end

local function transparency()
    local transparent_groups = {
        "Normal", "NormalNC", "NormalFloat", "StatusLine", "StatusLineNC",
        "SignColumn", "VertSplit", "EndOfBuffer", "WinSeparator",
        "LineNr", "CursorLine", "CursorLineNr", "FoldColumn",
        "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",

        "TelescopeNormal", "TelescopePromptNormal",
        "TelescopeResultsNormal", "TelescopePreviewNormal",

        "DiagnosticFloatError", "DiagnosticFloatWarn", "DiagnosticFloatInfo", "DiagnosticFloatHint",

        "CmpItemAbbr", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy",
        "CmpItemKind", "CmpItemMenu",
    }

    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
    end

    local border_groups = {
        "FloatBorder",
        "LspInfoBorder",
        "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
        "CmpBorder"
    }

    -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#44475a", fg = "#ffffff", bold = true })
    -- vim.api.nvim_set_hl(0, "CmpSel", { bg = "#44475a", fg = "#ffffff", bold = true })
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2e2e2e" })

    for _, group in ipairs(border_groups) do
        vim.api.nvim_set_hl(0, group, { fg = "#ffffff", bg = "NONE", ctermbg = "NONE" })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        --other_transparency()
    end,
})

--// use terminal colors
vim.o.termguicolors = false
--vim.o.background = 'dark'  -- or 'light'

vim.cmd([[colorscheme gruvbox]])
