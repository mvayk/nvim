return {
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer/selection",
        },
    },
    opts = {
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return nil
            end
            local ft = vim.bo[bufnr].filetype
            if ft == "c" or ft == "cpp" then
                return nil
            end
            return { timeout_ms = 2000, lsp_format = "never" }
        end,
        formatters_by_ft = {
            nix = { "alejandra" },
            lua = { "stylua" },
            python = { "ruff_organize_imports", "ruff_format" },
            rust = { "rustfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            --markdown = { "prettier" },
            yaml = { "prettier" },
            go = { "goimports", "gofmt" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            toml = { "taplo" },
            sql = { "sqlfmt" },
            java = { "google_java_format" },
            ruby = { "rubocop" },
            php = { "php_cs_fixer" },
            zig = { "zigfmt" },
        },
        formatters = {
            stylua = {
                prepend_args = function(_, ctx)
                    local found = vim.fs.find(
                        { "stylua.toml", ".stylua.toml", ".editorconfig" },
                        { path = ctx.dirname, upward = true }
                    )
                    if #found > 0 then
                        return {}
                    end
                    return { "--indent-type", "Spaces", "--indent-width", "4" }
                end,
            },
            shfmt = {
                prepend_args = function(_, ctx)
                    local found = vim.fs.find(".editorconfig", { path = ctx.dirname, upward = true })
                    if #found > 0 then
                        return {}
                    end
                    return { "-i", "4" }
                end,
            },
            clang_format = { prepend_args = { "--fallback-style=Google" } },
            prettier = { prepend_args = { "--config-precedence", "prefer-file" } },
        },
    },
    init = function()
        vim.api.nvim_create_user_command("FormatToggle", function(args)
            if args.bang then
                vim.b.disable_autoformat = not vim.b.disable_autoformat
            else
                vim.g.disable_autoformat = not vim.g.disable_autoformat
            end
        end, { bang = true, desc = "Toggle format-on-save (! = buffer-local)" })

        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.cmd("filetype indent off")
        vim.o.smartindent = false
        vim.o.cindent = false

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                vim.bo.indentexpr = ""
                vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tcro]", "")
            end,
        })
        vim.keymap.set({ "n", "v" }, "=", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format via conform" })
    end,
}
