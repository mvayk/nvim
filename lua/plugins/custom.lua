local enabled = false

if enabled then
    return {
        dir = "~/dev/nfetch.nvim",

        config = function()
            require("nfetch").setup({
                type = "fastfetch",
                width = 120,
                height = 20,
            })
        end
    }
else
    return { }
end
