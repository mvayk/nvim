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
                if vim.bo.filetype == "nix" then
                    require("conform").format({ async = true, lsp_fallback = false })
                else
                    vim.cmd("normal! =G")
                end
            end,
            desc = "Format buffer",
        },
    },
    config = function()
        require("conform").setup({
            format_on_save = function(bufnr)
                if vim.bo[bufnr].filetype ~= "nix" then
                    return nil
                end
                return { timeout_ms = 500, lsp_fallback = false }
            end,
            formatters_by_ft = {
                nix = { "alejandra" },
            },
        })
    end,
    --[[
    formatters_by_ft = {
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
        nix = { "nixfmt" },
        toml = { "taplo" },
        sql = { "sqlfmt" },
        java = { "google_java_format" },
        ruby = { "rubocop" },
        php = { "php_cs_fixer" },
        zig = { "zigfmt" },
        dockerfile = {},
        ["_"] = { "trim_whitespace" },
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
            prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
        },
        nixfmt = {
            prepend_args = { "--width", "80" },
        },
    },
    ]]
}
