local enabled = true
if enabled then
    return {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            -- Example: ">| 24"

            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                relculright = true,
                ft_ignore = { "neo-tree" },
                segments = {
                    --{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    --{ sign = { namespace = { "gitsigns.*" }, maxwidth = 1 } },
                    { sign = { namespace = { ".*diagnostic.*" }, maxwidth = 1 } },
                    { text = { builtin.lnumfunc, " " },
                    },
                }
            })
        end,
    }
else
    return { }
end
