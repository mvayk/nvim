return {
    "windwp/nvim-autopairs",
    check_ts = true,
    enabled = true,
    lazy = true,
    event = "VeryLazy",

    config = function()
        require("nvim-autopairs").setup({
            enable_moveright = true,
            enable_afterquote = true,
        })

        local rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

        npairs.add_rule(rule("/*", "*/"))
    end,
}
