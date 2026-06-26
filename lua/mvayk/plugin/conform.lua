return {
    "stevearc/conform.nvim",
    enabled = true,
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "=",
            function()
                local ft = vim.bo.filetype
                if ft == "c" or ft == "cpp" then
                    vim.cmd("normal! =G")
                else
                    require("conform").format({ async = true, lsp_fallback = false })
                end
            end,
            desc = "Format buffer",
        },
    },
    config = function()
        require("conform").setup({
            format_on_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                if ft == "c" or ft == "cpp" then
                    return nil
                end
                return { timeout_ms = 500, lsp_fallback = false }
            end,
            formatters_by_ft = {
                nix = { "alejandra" },
                lua = { "stylua" },
                python = { "ruff_format", "ruff_organize_imports" },
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
                zsh = { "shfmt" },
                toml = { "taplo" },
                sql = { "sqlfmt" },
                java = { "google_java_format" },
                ruby = { "rubocop" },
                php = { "php_cs_fixer" },
                zig = { "zigfmt" },
                dockerfile = {},
            },
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                },
                shfmt = {
                    prepend_args = { "-i", "4" },
                },
                clang_format = {
                    prepend_args = { "--style=Google" },
                },
                prettier = {
                    prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
                },
                nixfmt = {
                    prepend_args = { "--width", "80" },
                },
            },
        })
    end,
}
