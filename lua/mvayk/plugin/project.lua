return {
    "DrKJeff16/project.nvim",
    event = "VeryLazy",  -- or your preferred lazy loading
    config = function()
        require("project_nvim").setup({
            -- your existing options here (e.g. detection_methods, silent_chdir, etc.)
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "Makefile", "package.json" },  -- example
            -- add any other custom opts
        })

        -- Optional: integrate with telescope if you use it
        require("telescope").load_extension("projects")
    end,
}
