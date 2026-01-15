return {
    "DrKJeff16/project.nvim",
    config = function()
        require("project").setup({
            -- your existing options here (e.g. detection_methods, silent_chdir, etc.)
            -- detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "Makefile", "package.json", "flake.nix", "shell.nix" },  -- example
            -- add any other custom opts
            enable_autochdir = true,
            show_hidden = true,
        })

        -- Optional: integrate with telescope if you use it
        require("telescope").load_extension("projects")
    end,
}
