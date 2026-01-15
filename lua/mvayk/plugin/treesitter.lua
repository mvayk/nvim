return {
    "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",
    config = function()
        require'nvim-treesitter.configs'.setup {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,

                ensure_installed = { "c", "cpp", "lua", "vim", "nix" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },

                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                    },
                    keymaps = {
                    },
                },
            },
        }
    end
}

