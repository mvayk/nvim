--big thanks to big baby girl claude
-- blink
local config = require("mvayk.settings")
local enabled = config.lsp_enabled

local is_nixos = vim.fn.executable("nix-store") == 1

local servers = {
    "lua_ls",
    "clangd",
}

local mason_tools = {
    "ast_grep",
    "prettier",
    "ruff",
    --"clang-format",
    "goimports",
    "shfmt",
    "taplo",
    "stylua",
    "shellcheck",
    "hadolint",
    "markdownlint-cli2",
}

if enabled then
    local plugins = {
        { "lopi-py/luau-lsp.nvim" },
        { "mfussenegger/nvim-lint" },
        {
            "saghen/blink.compat",
            version = "2.*",
            lazy = true,
            opts = {},
        },
    }

    if not is_nixos then
        table.insert(plugins, { "williamboman/mason.nvim" })
        table.insert(plugins, { "williamboman/mason-lspconfig.nvim" })
        vim.api.nvim_create_autocmd("User", {
            pattern = "MasonUpdateAllComplete",
            once = true,
            callback = function()
                vim.cmd("MasonInstall " .. table.concat(mason_tools, " "))
            end,
        })
    end

    table.insert(plugins, {
        "neovim/nvim-lspconfig",
        dependencies = not is_nixos and {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        } or {
            "saghen/blink.cmp",
        },
        config = function()
            if not is_nixos then
                require("mason").setup()
                require("mason-lspconfig").setup({
                    ensure_installed = servers,
                    automatic_installation = true,
                    automatic_enable = {
                        exclude = { "luau_lsp" },
                    },
                })
            end

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

            local servers_to_enable
            if is_nixos then
                servers_to_enable = servers
            else
                local mason_lspconfig = require("mason-lspconfig")
                servers_to_enable = mason_lspconfig.get_installed_servers()
            end

            for _, server_name in ipairs(servers_to_enable) do
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
    })

    return plugins
else
    return {}
end
