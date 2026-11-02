return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "never" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer/selection",
        },
    },
    opts = {
        format_on_save = function(bufnr)
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
            markdown = { "prettier" },
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
            stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" } },
            shfmt = { prepend_args = { "-i", "4" } },
            clang_format = { prepend_args = { "--style=Google" } },
            prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
        },
    },
}
