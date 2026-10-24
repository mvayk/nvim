local preset = "pure" -- pure / slashed

local function get_opts(preset)
    if preset == "pure" then
        return {
            style = "fg",
            bold = true,
            configs = {
                path = {
                    hl = {
                        primary = "Label",
                    },
                },
                git = {
                    hl = {
                        primary = "Function",
                    },
                },
                filetype_lsp = {
                    hl = {
                        primary = "String",
                    },
                },
            },
        }
    else
        return {
            spaces = {
                components = "",
                left = "",
                right = "",
            },
            sep = {
                hide = { first = true, last = true },
                left = "",
                right = "",
            },
        }
    end
end

return {
    "sschleemilch/slimline.nvim",
    enabled = true,
    opts = get_opts(preset),
}
