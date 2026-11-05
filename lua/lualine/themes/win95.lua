local dark = vim.o.background == "dark"

local chrome = dark and "#aaaaaa" or "#c0c0c0"
local chrome_fg = "#000000"
local dim = dark and "#555555" or "#808080"
local white = "#ffffff"

local function section(mode_bg)
    return {
        a = { fg = white, bg = mode_bg, gui = "bold" },
        b = { fg = chrome_fg, bg = chrome },
        c = { fg = chrome_fg, bg = chrome },
    }
end

return {
    normal = section("#000080"),
    insert = section("#008000"),
    visual = section("#008080"),
    replace = section("#800000"),
    command = section("#800080"),
    terminal = section("#008000"),
    inactive = {
        a = { fg = dim, bg = chrome },
        b = { fg = dim, bg = chrome },
        c = { fg = dim, bg = chrome },
    },
}
