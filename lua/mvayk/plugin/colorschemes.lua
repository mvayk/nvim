-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

local settings = require("mvayk.settings")

local function install_colorschemes()
    return {
        { "rktjmp/lush.nvim", lazy = false },
        { "folke/tokyonight.nvim", lazy = false },
        { "rebelot/kanagawa.nvim", lazy = false },
        { "marko-cerovac/material.nvim", lazy = false },
        { "EdenEast/nightfox.nvim", lazy = false },
        { "yorumicolors/yorumi.nvim", lazy = false },
        { "scottmckendry/cyberdream.nvim", lazy = false },
        { "sainnhe/gruvbox-material", lazy = false },
        { "aktersnurra/no-clown-fiesta.nvim", lazy = false },
        { "datsfilipe/vesper.nvim", lazy = false },
        { "rafi/awesome-vim-colorschemes", lazy = false },
        { "zenbones-theme/zenbones.nvim", lazy = false },
        { "Yagua/nebulous.nvim", lazy = false },
        { "ramojus/mellifluous.nvim", lazy = false },
        { "metalelf0/jellybeans-nvim", lazy = false },
        { "Verf/deepwhite.nvim", lazy = false },
        { "kdheepak/monochrome.nvim", lazy = false },
        { "vague2k/vague.nvim", lazy = false },
        { "metalelf0/black-metal-theme-neovim", lazy = false },
        { "lunarvim/horizon.nvim", lazy = false },
        { "andersevenrud/nordic.nvim", lazy = false },
        { "oxfist/night-owl.nvim", lazy = false },
        { "slugbyte/lackluster.nvim", lazy = false },
        { "zootedb0t/citruszest.nvim", lazy = false },
        { "e-ink-colorscheme/e-ink.nvim", lazy = false },
        { "luisiacc/gruvbox-baby", lazy = false },
        { "catppuccin/nvim", name = "catppuccin", lazy = false },
        { "rose-pine/neovim", name = "rose-pine", lazy = false },
        { "nyoom-engineering/oxocarbon.nvim", lazy = false },
        { "bluz71/vim-moonfly-colors", lazy = false },
        { "bluz71/vim-nightfly-colors", lazy = false },
        { "jacoborus/tender.vim", lazy = false },
        { "savq/melange-nvim", lazy = false },
        { "rmehri01/onenord.nvim", lazy = false },
        { "olivercederborg/poimandres.nvim", lazy = false },
        { "xero/miasma.nvim", lazy = false },
        { "dgox16/oldworld.nvim", lazy = false },
        { "ficd0/ashen.nvim", lazy = false },
        { "water-sucks/darkrose.nvim", lazy = false },
        { "uhs-robert/oasis.nvim", lazy = false },
        { "casedami/neomodern.nvim", lazy = false },
        { "paulfrische/reddish.nvim", lazy = false },
        { "nikolvs/vim-sunbather", lazy = false },
        { "tiesen243/vercel.nvim", lazy = false },
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
