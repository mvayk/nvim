local enabled = false
if not enabled then return {} end
return {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        --"rcarriga/nvim-notify",
    },
    --[[ disable setup incase of startup error, and enable about install ]]
    --
    require("noice").setup({
        cmdline = {
            view = "cmdline",
        },
        messages = {
            enabled = true,
        },
        popupmenu = {
            enabled = true,  -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "nui", -- backend to use to show regular cmdline completions
            ---@type NoicePopupmenuItemKind|false
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            kind_icons = {}, -- set to `false` to disable icons
        },
        notify = {
            enabled = true,
        },
    }),
}
