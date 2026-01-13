local enabled = true
if enabled then
    return {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            -- Simple statuscolumn: [fold][git][diagnostic][line_number]
            -- Example: "+|x24"

            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                relculright = true,
                segments = {
                    -- UFO fold column
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },

                    -- Gitsigns (use namespace with wildcard pattern)
                    { sign = { namespace = { "gitsigns.*" }, maxwidth = 1 } },

                    -- LSP diagnostics
                    { sign = { namespace = { ".*diagnostic.*" }, maxwidth = 1 } },

                    -- Line number
                    { text = { builtin.lnumfunc, " " } }
                }
            })
        end,
    }
else
    return { }
end
