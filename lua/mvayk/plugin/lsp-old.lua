-- cmp
local config = require("mvayk.settings")
local enabled = false

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
    "tailwindcss",
}

local tools = {
    -- "nixfmt",
    -- "prettier",
    -- "ruff",
    -- "clang-format",
    -- "goimports",
    -- "shfmt",
    -- "taplo",
    -- "stylua",
    -- "shellcheck",
    -- "hadolint",
    -- "markdownlint-cli2",
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
        { "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets", "molleweide/LuaSnip-snippets.nvim" },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        { "saadparwaiz1/cmp_luasnip" },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "saadparwaiz1/cmp_luasnip",
                "L3MON4D3/LuaSnip",
            },
            config = function()
                local cmp = require("cmp")
                local luasnip = require("luasnip")

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-j>"] = cmp.mapping.select_next_item(),
                        ["<C-k>"] = cmp.mapping.select_prev_item(),
                        ["<Tab>"] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.confirm({ select = true })
                            elseif luasnip.locally_jumpable(1) then
                                luasnip.jump(1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ["<S-Tab>"] = cmp.mapping(function(fallback)
                            if luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { "i", "s" }),
                        ["<C-Space>"] = cmp.mapping(function()
                            if cmp.visible() then
                                cmp.close()
                            else
                                cmp.complete()
                            end
                        end),
                        ["<C-h>"] = cmp.mapping.close(),
                        ["<CR>"] = cmp.mapping(function(fallback)
                            fallback()
                        end),
                    }),
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "path" },
                        { name = "buffer" },
                    }),
                    completion = {
                        completeopt = "menu,menuone,noinsert",
                    },
                    experimental = {
                        ghost_text = true,
                    },
                    window = {
                        documentation = cmp.config.window.bordered({
                            border = config.border,
                            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                            max_width = 90,
                        }),
                        completion = cmp.config.window.bordered({
                            border = config.border,
                            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                            max_height = 15,
                        }),
                    },
                    formatting = {
                        fields = { "abbr", "kind" },
                        expandable_indicator = true,
                    },
                    performance = {
                        max_view_entries = 2000,
                    },
                })
            end,
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "hrsh7th/cmp-nvim-lsp",
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
                        prefix = "",
                    },
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "",
                            [vim.diagnostic.severity.WARN] = "",
                            [vim.diagnostic.severity.INFO] = "",
                            [vim.diagnostic.severity.HINT] = "",
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

                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                local mason_lspconfig = require("mason-lspconfig")
                local installed_servers = mason_lspconfig.get_installed_servers()

                for _, server_name in ipairs(installed_servers) do
                    if server_name ~= "luau_lsp" then
                        if server_name == "lua_ls" then
                            vim.lsp.config["lua_ls"] = {
                                capabilities = capabilities,
                                settings = {
                                    Lua = {
                                        diagnostics = {
                                            globals = { "vim" },
                                        },
                                        workspace = {
                                            library = { vim.env.VIMRUNTIME },
                                            checkThirdParty = false,
                                        },
                                    },
                                },
                            }
                        else
                            vim.lsp.config[server_name] = {
                                capabilities = capabilities,
                            }
                        end

                        vim.lsp.enable(server_name)
                    end
                end
            end,
        },
    }
else
    return {}
end
