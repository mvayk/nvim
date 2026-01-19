# big thanks to big baby girl claude
local enabled = true

if enabled then
    return {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "stevearc/conform.nvim" },
        { "nvimdev/lspsaga.nvim" },
        { "hedyhli/outline.nvim" },
        { "lopi-py/luau-lsp.nvim" },
        {
            "saghen/blink.compat",
            version = "2.*",
            lazy = true,
            opts = {},
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            dependencies = {
                "rafamadriz/friendly-snippets",
                "saghen/blink.compat",
            },
            opts = {
                keymap = {
                    preset = "default",
                    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<C-e>"] = { "hide", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },
                },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = "mono",
                },

                completion = {
                    trigger = {
                        show_on_keyword = true,
                        show_on_trigger_character = true,
                        show_on_insert_on_trigger_character = false,
                    },
                    list = {
                        max_items = 200,
                    },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    menu = {
                        max_height = 10,
                        border = "none",
                        winblend = 0,
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                        auto_show_delay_ms = 0,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label", "label_description", gap = 1 },
                            },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        window = {
                            border = "none",
                            winblend = 0,
                            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                            max_width = 60,
                        },
                    },
                },

                sources = {
                    default = { "lsp", "path", "snippets", "buffer"};
                },

                signature = {
                    enabled = true,
                    window = {
                        border = "none",
                    },
                },
            },
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "saghen/blink.cmp",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls", "clangd", "ast_grep", "nil_ls", "rust_analyzer" },
                    automatic_installation = true,
                    automatic_enable = {
                        exclude = { "luau_lsp" }
                    },
                })

                require("luau-lsp").setup({
                    platform = {
                        type = "roblox"
                    },
                    types = {
                        roblox_security_level = "PluginSecurity"
                    },
                })

                vim.diagnostic.config({
                    virtual_text = true,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "",
                            [vim.diagnostic.severity.WARN]  = "",
                            [vim.diagnostic.severity.INFO]  = "",
                            [vim.diagnostic.severity.HINT]  = "",
                        },
                    },
                    underline = true,
                    update_in_insert = true,
                    severity_sort = true,
                    float = {
                        border = "none",
                        source = "always",
                        header = "",
                        prefix = "",
                    },
                })

                local capabilities = require("blink.cmp").get_lsp_capabilities()
                local mason_lspconfig = require("mason-lspconfig")
                local installed_servers = mason_lspconfig.get_installed_servers()

                for _, server_name in ipairs(installed_servers) do
                    if server_name ~= "luau_lsp" then
                        vim.lsp.config[server_name] = {
                            capabilities = capabilities,
                        }

                        vim.lsp.enable(server_name)
                    end
                end
            end,
        },
    }
else
    return {}
end
