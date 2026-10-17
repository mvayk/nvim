return {
    "vyfor/cord.nvim",
    enabled = true,
    build = ":Cord update",
    ---@type CordConfig
    opts = {
        display = {
            theme = "minecraft",
            flavor = "dark",
        }
    }
}
