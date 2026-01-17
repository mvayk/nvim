local enabled = false
if enabled then
    return {
        -- Calls `require('slimline').setup({})`
        "sschleemilch/slimline.nvim",
        opts = {
            spaces = {
                components = "",
                left = "",
                right = "",
            },
            sep = {
                hide = {
                    first = true,
                    last = true,
                },
                left = "",
                right = "",
            },
        }

    }
else
    return { }
end
