return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        scope = {
            enabled = true, -- keep the current scope highlight (vertical line through the block)
            show_start = false, -- ← disables underline on first line of scope
            show_end = false, -- ← disables underline on last line of scope
        },
        whitespace = {
            highlight = "Whitespace",
            remove_blankline_trail = false,
        },
    },
}
