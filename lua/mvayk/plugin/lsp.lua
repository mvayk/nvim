--big thanks to big baby girl claude
local config = require("mvayk.settings")

local enabled = true

local servers = {
    "lua_ls",
    "clangd",
    "ast_grep",
    "nil_ls",
    "rust_analyzer",
    "pyright",
    "ts_ls",
    "html",
    "cssls",
    "eslint",
    "gopls",
    "bashls",
    "jsonls",
    "yamlls",
    "taplo",
    "dockerls",
    "zls",
}

local tools = {
    "prettier",
    "ruff",
    "clang-format",
    "goimports",
    "shfmt",
    "taplo",
    "stylua",
    "shellcheck",
    "hadolint",
    "markdownlint-cli2",
}

vim.api.nvim_create_autocmd("User", {
    pattern = "MasonUpdateAllComplete",
    once = true,
    callback = function()
        vim.cmd("MasonInstall " .. table.concat(tools, " "))
    end,
})

if enabled then
    return {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "lopi-py/luau-lsp.nvim" },
        { "mfussenegger/nvim-lint" },
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
                "molleweide/LuaSnip-snippets.nvim",
            },
            opts = {
                -- blink cmp configuration
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
                    nerd_font_variant = "mono",
                    kind_icons = {
                        Text = "󰉿",
                        Method = "󰊕",
                        Function = "󰊕",
                        Constructor = "󰒓",
                        Field = "󰜢",
                        Variable = "󰆦",
                        Class = "󱡠",
                        Interface = "󱡠",
                        Module = "󰅩",
                        Property = "󰖷",
                        Unit = "󰪚",
                        Value = "󰦨",
                        Enum = "󰦨",
                        Keyword = "󰻾",
                        Snippet = "󱄽",
                        Color = "󰏘",
                        File = "󰈔",
                        Reference = "󰬲",
                        Folder = "󰉋",
                        EnumMember = "󰦨",
                        Constant = "󰏿",
                        Struct = "󱡠",
                        Event = "󱐋",
                        Operator = "󰪚",
                        TypeParameter = "󰬛",
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
                        show_on_insert_on_trigger_character = true,
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
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        window = {
                            border = config.border,
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
                        border = config.border,
                        winblend = 0,
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                        auto_show_delay_ms = 0,
                        draw = {
                            treesitter = { "lsp" },
                            padding = 1,
                            gap = 1,
                            columns = {
                                { "label", "label_description", gap = 1 },
                                { "kind_icon", gap = 1 },
                            },
                        },
                    },
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                signature = {
                    enabled = false,
                    window = {
                        border = config.border,
                        show_documentation = true,
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
                    ensure_installed = servers,
                    automatic_installation = true,
                    automatic_enable = {
                        exclude = { "luau_lsp" },
                    },
                })

                require("luau-lsp").setup({
                    platform = {
                        type = "roblox",
                    },
                    types = {
                        roblox_security_level = "PluginSecurity",
                    },
                })

                vim.diagnostic.config({
                    undercurl = true,
                    underline = true,
                    update_in_insert = true,
                    severity_sort = true,
                    virtual_text = {
                        true,
                        spacing = 25,
                        prefix = "",
                    },
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "",
                            [vim.diagnostic.severity.WARN] = "",
                            [vim.diagnostic.severity.INFO] = "",
                            [vim.diagnostic.severity.HINT] = "",
                        },
                    },
                    float = {
                        border = config.border,
                        source = "always",
                        header = "",
                        prefix = "",
                        focusable = false,
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
