local settings = require("mvayk.settings")

if settings.lsp_enabled then
    return {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
            "molleweide/LuaSnip-snippets.nvim",
        },
        opts = {
            keymap = {
                preset = "default",
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
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
                use_nvim_cmp_as_default = false,
                --nerd_font_variant = "mono",
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert = true,
                },
                window = {
                    border = settings.border,
                    show_documentation = false,
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
                    max_items = 200,
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                documentation = {
                    auto_show = false,
                    auto_show_delay_ms = 0,
                    window = {
                        border = settings.border,
                        winblend = 0,
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                        max_width = 90,
                    },
                },
                menu = {
                    auto_show = function()
                        return vim.b.menu_auto_show ~= false
                    end,
                    max_height = 15,
                    border = settings.border,
                    winblend = 0,
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                    auto_show_delay_ms = 0,
                    draw = {
                        padding = 1,
                        gap = 1,
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                            --{ "kind_icon", "kind" },
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
    }
end
