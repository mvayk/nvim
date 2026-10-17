return {
    "vyfor/cord.nvim",
    enabled = true,
    build = ":Cord update",

    config = function()
        display = {
            theme = "minecraft",
            flavour = "dark",
        }
    end,
}
