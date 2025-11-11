local enabled = false

if enabled then
    return {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_mappings()
        end
    }
else
    return { }
end
