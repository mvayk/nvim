local settings = require("settings")

if settings.lsp_enabled then
    return {
        "saghen/blink.cmp",
        --version = "1.*",
        dependencies = {
            "saghen/blink.lib", -- required only for blink.cmp v2 users
            "rafamadriz/friendly-snippets",
            "molleweide/LuaSnip-snippets.nvim",
            "saghen/blink.compat",
            -- "Kaiser-Yang/blink-cmp-git",
            -- "mikavilpas/blink-ripgrep.nvim",
            -- "bydlw98/blink-cmp-env",
            -- "xieyonn/blink-cmp-dat-word",
        },
        build = function()
            -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
            -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
            require("blink.cmp").build():pwait()
        end,
        opts = {
            keymap = {
                preset = "default",
                ["<C-S-j>"] = { "scroll_documentation_down", "fallback" },
                ["<C-S-k>"] = { "scroll_documentation_up", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                --["<Tab>"] = { "select_next", "fallback" },
                --["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
                ["<C-Space>"] = { "show", "hide", "fallback" },

                ["<C-h>"] = { "hide", "fallback" },
                ["<CR>"] = { "fallback" },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                --nerd_font_variant = "mono",
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert = true,
                },
                window = {
                    border = settings.border,
                    show_documentation = settings.show_blink_documentation,
                },
            },
            completion = {
                --scrollbar = false,
                ghost_text = {
                    enabled = true,
                },
                trigger = {
                    show_on_keyword = true,
                    show_on_trigger_character = true,
                },
                list = {
                    selection = {
                        auto_insert = false,
                        preselect = true,
                    },
                    max_items = 2000,
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                documentation = {
                    auto_show = settings.show_blink_documentation, --false
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = false,
                    window = {
                        border = settings.border,
                        --winblend = 0,
                        --winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                        max_width = 40,
                    },
                },
                menu = {
                    auto_show = function()
                        return vim.b.menu_auto_show ~= false
                    end,
                    max_height = 15,
                    border = settings.border,
                    -- winblend = 0,
                    -- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    auto_show_delay_ms = 0,
                    draw = {
                        -- padding = 1,
                        -- gap = 1,
                        columns = vim.g.neovide and { { "label", gap = 1 }, { "kind_icon" }, { "kind" } }
                            or { { "label", gap = 1 }, { "kind" } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "omni" },
            },
        },
    }
end
