local enabled = true

if enabled then
    return {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        -- { "neovim/nvim-lspconfig" },
        { "ray-x/lsp_signature.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        -- { "stevearc/conform.nvim" },
        -- { "nvimdev/lspsaga.nvim" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-emoji" },
        { "onsails/lspkind.nvim" },
        { "hrsh7th/cmp-calc" },
        { "ray-x/cmp-treesitter" },
        --> { "f3fora/cmp-spell" },
        { "petertriho/cmp-git" },
        { "L3MON4D3/LuaSnip" },
        { "lopi-py/luau-lsp.nvim" },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "hrsh7th/nvim-cmp",
                "hrsh7th/cmp-nvim-lsp",
                "L3MON4D3/LuaSnip",
            },
            config = function()
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls" },
                    automatic_installation = true,
                    automatic_enable = {
                        exclude = { "luau_lsp" }
                    },
                })

                local signature_config = {event="InsertEnter"}
                require("lsp_signature").setup(signature_config)

                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "lua",
                        "c",
                        "cpp",
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
                    virtual_text = true, -- inline text
                    signs = true,        -- show signs
                    underline = true,    -- underline errors/warnings
                    update_in_insert = false,
                    float = {
                        border = "rounded", -- <-- make the diagnostic popup rounded
                        source = "always",  -- show source
                        header = "",        -- optional header
                        prefix = "",        -- optional prefix
                    },
                })


                --> lsp servers
                local capabilities = require("cmp_nvim_lsp").default_capabilities()

                --> completion menu
                vim.api.nvim_set_hl(0, "CmpBorder", { link = "NormalFloat" })
                local lspkind = require("lspkind")
                local cmp = require("cmp")
                cmp.setup({
                    formatting = {
                        format = lspkind.cmp_format({
                            mode = "symbol_text",
                            ellipsis_char = '...',
                            show_labelDetails = true,
                        }),
                    },
                    mapping = cmp.mapping.preset.insert({
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-j>"] = cmp.mapping.select_next_item(),
                        ["<C-k>"] = cmp.mapping.select_prev_item(),
                        ["<Tab>"] = cmp.mapping.select_next_item(),
                        ["<S-tab>"] = cmp.mapping.select_prev_item(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    }),
                    completion = {
                        keyword_length = 0,
                    },
                    performance = {
                        debounce = 0,
                        throttle = 0,
                        fetching_timeout = 50,
                    },
                    snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end,
                    },
                    window = {
                        completion = cmp.config.window.bordered({
                            border = "rounded",
                            winhighlight = "Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                            max_width = 50,
                            scrollbar = false,
                            col_offset = 0,
                        }),
                        documentation = cmp.config.window.bordered({
                            border = "rounded",
                            winhighlight = "Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                            scrollbar = false,
                            max_width = 60,
                        }),
                    },
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "path" },
                        { name = "buffer" },
                        { name = "emoji" },
                        { name = "calc" },
                        --> this is really annoying { name = "spell" },
                        { name = "treesitter" },
                    }),
                })
            end,
        },
    }
else
    return { }
end
