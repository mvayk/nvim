-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

local settings = require("mvayk.settings")

local function install_colorschemes()
    local lazy_enabled = true
    return {
        { "rktjmp/lush.nvim", lazy = lazy_enabled },
        { "folke/tokyonight.nvim", lazy = lazy_enabled },
        { "rebelot/kanagawa.nvim", lazy = lazy_enabled },
        { "marko-cerovac/material.nvim", lazy = lazy_enabled },
        { "EdenEast/nightfox.nvim", lazy = lazy_enabled },
        { "yorumicolors/yorumi.nvim", lazy = lazy_enabled },
        { "scottmckendry/cyberdream.nvim", lazy = lazy_enabled },
        { "sainnhe/gruvbox-material", lazy = lazy_enabled },
        { "aktersnurra/no-clown-fiesta.nvim", lazy = lazy_enabled },
        { "datsfilipe/vesper.nvim", lazy = lazy_enabled },
        { "rafi/awesome-vim-colorschemes", lazy = lazy_enabled },
        { "zenbones-theme/zenbones.nvim", lazy = lazy_enabled },
        { "Yagua/nebulous.nvim", lazy = lazy_enabled },
        { "ramojus/mellifluous.nvim", lazy = lazy_enabled },
        { "metalelf0/jellybeans-nvim", lazy = lazy_enabled },
        { "Verf/deepwhite.nvim", lazy = lazy_enabled },
        { "kdheepak/monochrome.nvim", lazy = lazy_enabled },
        { "vague2k/vague.nvim", lazy = lazy_enabled },
        { "metalelf0/black-metal-theme-neovim", lazy = lazy_enabled },
        { "lunarvim/horizon.nvim", lazy = lazy_enabled },
        { "andersevenrud/nordic.nvim", lazy = lazy_enabled },
        { "oxfist/night-owl.nvim", lazy = lazy_enabled },
        { "slugbyte/lackluster.nvim", lazy = lazy_enabled },
        { "zootedb0t/citruszest.nvim", lazy = lazy_enabled },
        { "e-ink-colorscheme/e-ink.nvim", lazy = lazy_enabled },
        { "luisiacc/gruvbox-baby", lazy = lazy_enabled },
        { "catppuccin/nvim", name = "catppuccin", lazy = lazy_enabled },
        { "rose-pine/neovim", name = "rose-pine", lazy = lazy_enabled },
        { "nyoom-engineering/oxocarbon.nvim", lazy = lazy_enabled },
        { "bluz71/vim-moonfly-colors", lazy = lazy_enabled },
        { "bluz71/vim-nightfly-colors", lazy = lazy_enabled },
        { "jacoborus/tender.vim", lazy = lazy_enabled },
        { "savq/melange-nvim", lazy = lazy_enabled },
        { "rmehri01/onenord.nvim", lazy = lazy_enabled },
        { "olivercederborg/poimandres.nvim", lazy = lazy_enabled },
        { "xero/miasma.nvim", lazy = lazy_enabled },
        { "dgox16/oldworld.nvim", lazy = lazy_enabled },
        { "ficd0/ashen.nvim", lazy = lazy_enabled },
        { "water-sucks/darkrose.nvim", lazy = lazy_enabled },
        { "uhs-robert/oasis.nvim", lazy = lazy_enabled },
        { "casedami/neomodern.nvim", lazy = lazy_enabled },
        { "paulfrische/reddish.nvim", lazy = lazy_enabled },
        { "nikolvs/vim-sunbather", lazy = lazy_enabled },
        { "tiesen243/vercel.nvim", lazy = lazy_enabled },
    }
end

if settings.use_base16_colorscheme then
    return {
        install_colorschemes(),
        "RRethy/base16-nvim",
        config = function()
            require("matugen").setup()
        end,
    }
else
    return {
        install_colorschemes(),
    }
end
