local enabled = false

if enabled then
    return {
        -- Package manager dependencies
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
        { "lopi-py/luau-lsp.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

        -- Blink autocomplete and its sources
        {
            "saghen/blink.cmp",
            version = "1.*",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
            },
        },

        -- LSP configuration
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "saghen/blink.cmp",
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
            },
            config = function()
                -- Mason setup
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls", "clangd", "rust_analyzer" },
                    automatic_installation = true,
                })

                -- Autocomplete capabilities
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

                -- LSP setups
                require("lspconfig").lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                })

                require("lspconfig").rust_analyzer.setup({
                    capabilities = capabilities,
                })

                require("lspconfig").ast_grep.setup({
                    capabilities = capabilities,
                })

                -- Detect Windows for custom clangd path
                local clangd_path = "clangd"
                if vim.loop.os_uname().version:match("Windows") then
                    local local_appdata = vim.loop.os_getenv("LOCALAPPDATA")
                    clangd_path = local_appdata .. "\\nvim-data\\mason\\packages\\clangd\\clangd_20.1.0\\bin\\clangd.exe"
                end

                require("lspconfig").clangd.setup({
                    cmd = { clangd_path },
                    capabilities = capabilities,
                    init_options = {},
                })

                -- Treesitter setup
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "lua", "c", "cpp", "rust" },
                    highlight = { enable = true },
                })

                -- Blink autocomplete setup
                require("blink.cmp").setup({
                    keymap = {
                        ["<C-f>"] = { scroll_documentation_down = true },
                        ["<C-b>"] = { scroll_documentation_up = true },
                        ["<C-j>"] = { select_next = true },
                        ["<C-k>"] = { select_prev = true },
                        ["<Tab>"] = { select_next = true },
                        ["<S-Tab>"] = { select_prev = true },
                        ["<C-e>"] = { hide = true },
                        ["<CR>"] = { accept = true },
                    },
                    completion = {
                        documentation = { auto_show = true },
                    },
                    sources = {
                        default = { "lsp", "path", "snippets", "buffer" },
                    },
                    fuzzy = {
                        implementation = "prefer_rust_with_warning",
                    },
                    appearance = {
                        nerd_font_variant = "mono",
                    },
                })

                -- Load friendly-snippets for LuaSnip
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    }
else
    return { }
end
