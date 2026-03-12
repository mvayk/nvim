return {
    "dnlhc/glance.nvim",
    enabled = true,
    cmd = "Glance",

    config = function()
        require("glance").setup({})
    end,
}
