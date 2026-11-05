local M = {}

function M.setup()
    local function location()
        return string.format("Ln %d, Col %d", vim.fn.line("."), vim.fn.virtcol("."))
    end

    require("lualine").setup({
        options = {
            theme = "auto", --// win95
            icons_enabled = true,
            globalstatus = false,
            section_separators = { left = "", right = "" },
            component_separators = { left = "│", right = "│" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { { "mode", padding = { left = 1, right = 1 } } },
            lualine_b = {
                "branch",
                {
                    "filename",
                    path = 1,
                    symbols = { modified = " [+]", readonly = " [RO]", unnamed = "[No Name]", newfile = "[New]" },
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    colored = false,
                    symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
                },
            },
            lualine_x = {
                { "filetype", fmt = string.upper },
                { "encoding", fmt = string.upper },
                { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
            },
            lualine_y = { "progress" },
            lualine_z = { location },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { location },
            lualine_y = {},
            lualine_z = {},
        },
    })
end

return M
