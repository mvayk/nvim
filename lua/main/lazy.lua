local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --> Aesthetic
    {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {'rcarriga/nvim-notify'},
    {'goolord/alpha-nvim'},

    --> Themes
    {'folke/tokyonight.nvim', lazy = false},
    {'ellisonleao/gruvbox.nvim'},
    {'bluz71/vim-nightfly-colors'},
    {'catppuccin/nvim', name = 'catpuccin'},
    {'rebelot/kanagawa.nvim'},
    {'rose-pine/neovim', name = 'rose-pine'},
    {'EdenEast/nightfox.nvim'},
    {'kepano/flexoki-neovim', name = "flexoki"},
    {'Enonya/yuyuko.vim'},

    --> Functional
    {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = {'nvim-lua/plenary.nvim'}},
    -- {'Exafunction/codeium.vim', dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"}},
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    --> LSP / Codecompletion
    {"lopi-py/luau-lsp.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'mfussenegger/nvim-lint'},
    {'folke/neodev.nvim'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/cmp-vsnip'},
    {'hrsh7th/vim-vsnip'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'L3MON4D3/LuaSnip'},
    {'saadparwaiz1/cmp_luasnip'},
})
