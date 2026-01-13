# big thanks to big baby girl claude
local enabled = true

if enabled then
    return {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
        { "stevearc/conform.nvim" },
        { "nvimdev/lspsaga.nvim" },
        { "hedyhli/outline.nvim" },
        { "lopi-py/luau-lsp.nvim" },

        -- Blink.compat for nvim-cmp sources
        {
            "saghen/blink.compat",
            version = "2.*", -- Use v2.* for blink.cmp v1.*
            lazy = true,
            opts = {},
        },

        -- Blink.cmp and its dependencies
        {
            "saghen/blink.cmp",
            version = "1.*", -- Use stable release
            dependencies = {
                "rafamadriz/friendly-snippets", -- Snippet collection
                "moyiz/blink-emoji.nvim", -- Emoji source
                "Kaiser-Yang/blink-cmp-git", -- Git source
                "saghen/blink.compat", -- nvim-cmp compatibility layer
                "hrsh7th/cmp-calc", -- Calculator source via compat
            },
            opts = {
                keymap = {
                    preset = "default",
                    -- Custom keymaps matching your original configuration
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
                    use_nvim_cmp_as_default = true, -- Use nvim-cmp-like appearance
                    nerd_font_variant = "mono",
                },

                completion = {
                    trigger = {
                        show_on_keyword = true,
                        show_on_trigger_character = true,
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
                        -- Add delay to prevent fast event context errors
                        auto_show_delay_ms = 100,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label", "label_description", gap = 1 },
                            },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 100,
                        window = {
                            border = "none",
                            winblend = 0,
                            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                            max_width = 60,
                        },
                    },
                },

                sources = {
                    -- Add all sources to default list
                    -- Built-in: lsp, path, snippets, buffer
                    -- Custom: emoji, calc, git
                    default = { "lsp", "path", "snippets", "buffer", "emoji", "calc", "git" },

                    providers = {
                        emoji = {
                            name = "Emoji",
                            module = "blink-emoji",
                            score_offset = -5,
                            opts = {
                                insert = true, -- Insert emoji instead of name
                            },
                        },

                        -- nvim-cmp source via blink.compat
                        calc = {
                            name = "Calc",
                            module = "blink.compat.source",
                            score_offset = -4,
                        },

                        git = {
                            name = "Git",
                            module = "blink-cmp-git",
                            score_offset = -10,
                        },
                    },
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
                    ensure_installed = { "lua_ls", "clangd", "ast_grep" },
                    automatic_installation = true,
                    automatic_enable = {
                        exclude = { "luau_lsp" }
                    },
                })

                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "lua",
                        "c",
                        "cpp",
                        "python",
                        "rust",
                    },
                    highlight = {
                        enable = true,
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

                -- Get blink.cmp capabilities for LSP servers
                local capabilities = require("blink.cmp").get_lsp_capabilities()

                -- Setup LSP servers using the new vim.lsp.config API (nvim 0.11+)
                local mason_lspconfig = require("mason-lspconfig")
                local installed_servers = mason_lspconfig.get_installed_servers()

                for _, server_name in ipairs(installed_servers) do
                    if server_name ~= "luau_lsp" then -- Skip luau_lsp as it's configured separately
                        -- Use the new vim.lsp.config API
                        vim.lsp.config[server_name] = {
                            capabilities = capabilities,
                        }

                        -- Enable the LSP server
                        vim.lsp.enable(server_name)
                    end
                end
            end,
        },
    }
else
    return {}
end
