local M = {}

function load()
    require("lualine").setup({
        options = {
            theme = "auto",
            component_separators = "",
            section_separators = { left = "", right = "" },
        },
        inactive_sections = {
            lualine_c = { "%f %y %m" },
            lualine_x = {},
        },
    })
end

return M
