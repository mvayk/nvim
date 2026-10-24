return {
    "DrKJeff16/project.nvim",
    enabled = true,
    lazy = false,
    event = "VeryLazy",
    config = function()
        require("project").setup({
            -- your existing options here (e.g. detection_methods, silent_chdir, etc.)
            --detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "package.json", "flake.nix", "shell.nix", "compile_commands.json"}, -- example
            -- add any other custom opts
            -- enable_autochdir = false,
            -- show_hidden = true,
        })
    end,
}
