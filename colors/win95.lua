local palettes = {
    light = {
        bg = "#ffffff",
        fg = "#000000",
        chrome = "#c0c0c0",
        chrome_fg = "#000000",
        dim = "#808080",
        line = "#eeeeee",
        sel_bg = "#000080",
        sel_fg = "#ffffff",
        search_bg = "#ffff00",
        search_fg = "#000000",
        comment = "#008000",
        string = "#800000",
        keyword = "#000080",
        type = "#008080",
        number = "#800080",
        special = "#808000",
        err = "#ff0000",
        warn = "#808000",
        info = "#000080",
        hint = "#008080",
        ok = "#008000",
        diff_add = "#c0ffc0",
        diff_del = "#ffc0c0",
        diff_chg = "#ffffc0",
        diff_txt = "#ffff00",
    },
    dark = {
        bg = "#0000aa",
        fg = "#ffff55",
        chrome = "#aaaaaa",
        chrome_fg = "#000000",
        dim = "#555555",
        line = "#0000c8",
        sel_bg = "#00aaaa",
        sel_fg = "#000000",
        search_bg = "#ffff55",
        search_fg = "#000000",
        comment = "#aaaaaa",
        string = "#55ffff",
        keyword = "#ffffff",
        type = "#55ff55",
        number = "#ff55ff",
        special = "#ff5555",
        err = "#ff5555",
        warn = "#ffaa00",
        info = "#55ffff",
        hint = "#55ff55",
        ok = "#55ff55",
        diff_add = "#005500",
        diff_del = "#550000",
        diff_chg = "#555500",
        diff_txt = "#888800",
    },
}

local p = palettes[vim.o.background == "dark" and "dark" or "light"]

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "win95"

local function hl(name, opts)
    vim.api.nvim_set_hl(0, name, opts)
end

-- Editor
hl("Normal", { fg = p.fg, bg = p.bg })
hl("NormalNC", { fg = p.fg, bg = p.bg })
hl("Cursor", { fg = p.bg, bg = p.fg })
hl("lCursor", { fg = p.bg, bg = p.fg })
hl("CursorLine", { bg = p.line })
hl("ColorColumn", { bg = p.line })
hl("Visual", { fg = p.sel_fg, bg = p.sel_bg })
hl("LineNr", { fg = p.dim, bg = p.bg })
hl("CursorLineNr", { fg = p.fg, bg = p.line, bold = true })
hl("SignColumn", { bg = p.bg })
hl("FoldColumn", { fg = p.dim, bg = p.bg })
hl("Folded", { fg = p.dim, bg = p.line })
hl("NonText", { fg = p.dim })
hl("EndOfBuffer", { fg = p.bg })
hl("Whitespace", { fg = p.dim })
hl("MatchParen", { fg = p.sel_fg, bg = p.sel_bg })
hl("Search", { fg = p.search_fg, bg = p.search_bg })
hl("CurSearch", { fg = p.sel_fg, bg = p.sel_bg })
hl("IncSearch", { fg = p.sel_fg, bg = p.sel_bg })
hl("Substitute", { fg = p.search_fg, bg = p.search_bg })

-- Chrome (the gray stuff)
hl("StatusLine", { fg = p.chrome_fg, bg = p.chrome })
hl("StatusLineNC", { fg = p.dim, bg = p.chrome })
hl("WinSeparator", { fg = p.dim, bg = p.bg })
hl("VertSplit", { fg = p.dim, bg = p.bg })
hl("TabLine", { fg = p.chrome_fg, bg = p.chrome })
hl("TabLineSel", { fg = p.sel_fg, bg = p.sel_bg, bold = true })
hl("TabLineFill", { bg = p.chrome })
hl("WinBar", { fg = p.chrome_fg, bg = p.chrome })
hl("WinBarNC", { fg = p.dim, bg = p.chrome })
hl("NormalFloat", { fg = p.chrome_fg, bg = p.chrome })
hl("FloatBorder", { fg = p.chrome_fg, bg = p.chrome })
hl("FloatTitle", { fg = p.sel_fg, bg = p.sel_bg, bold = true })
hl("Pmenu", { fg = p.chrome_fg, bg = p.chrome })
hl("PmenuSel", { fg = p.sel_fg, bg = p.sel_bg })
hl("PmenuSbar", { bg = p.dim })
hl("PmenuThumb", { bg = p.chrome_fg })
hl("MsgArea", { fg = p.fg, bg = p.bg })
hl("ModeMsg", { fg = p.fg, bold = true })
hl("MoreMsg", { fg = p.ok })
hl("Question", { fg = p.ok })
hl("ErrorMsg", { fg = p.err, bold = true })
hl("WarningMsg", { fg = p.warn, bold = true })
hl("Title", { fg = p.keyword, bold = true })
hl("Directory", { fg = p.keyword })
hl("WildMenu", { fg = p.sel_fg, bg = p.sel_bg })

-- Syntax
hl("Comment", { fg = p.comment })
hl("Constant", { fg = p.number })
hl("String", { fg = p.string })
hl("Character", { fg = p.string })
hl("Number", { fg = p.number })
hl("Boolean", { fg = p.number })
hl("Float", { fg = p.number })
hl("Identifier", { fg = p.fg })
hl("Function", { fg = p.fg })
hl("Statement", { fg = p.keyword, bold = true })
hl("Conditional", { fg = p.keyword, bold = true })
hl("Repeat", { fg = p.keyword, bold = true })
hl("Keyword", { fg = p.keyword, bold = true })
hl("Operator", { fg = p.fg })
hl("PreProc", { fg = p.special })
hl("Include", { fg = p.special })
hl("Type", { fg = p.type })
hl("Special", { fg = p.special })
hl("Delimiter", { fg = p.fg })
hl("Underlined", { underline = true })
hl("Todo", { fg = p.search_fg, bg = p.search_bg, bold = true })
hl("Error", { fg = p.err, bold = true })

-- Diagnostics
hl("DiagnosticError", { fg = p.err })
hl("DiagnosticWarn", { fg = p.warn })
hl("DiagnosticInfo", { fg = p.info })
hl("DiagnosticHint", { fg = p.hint })
hl("DiagnosticOk", { fg = p.ok })
hl("DiagnosticUnderlineError", { underline = true, sp = p.err })
hl("DiagnosticUnderlineWarn", { underline = true, sp = p.warn })
hl("DiagnosticUnderlineInfo", { underline = true, sp = p.info })
hl("DiagnosticUnderlineHint", { underline = true, sp = p.hint })

-- Diff
hl("DiffAdd", { bg = p.diff_add })
hl("DiffDelete", { bg = p.diff_del })
hl("DiffChange", { bg = p.diff_chg })
hl("DiffText", { bg = p.diff_txt })
hl("Added", { fg = p.ok })
hl("Removed", { fg = p.err })
hl("Changed", { fg = p.warn })
