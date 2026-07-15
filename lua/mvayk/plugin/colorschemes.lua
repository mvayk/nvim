-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

local settings = require("mvayk.settings")

local function install_colorschemes()
    local q = false
    return {
        { "rktjmp/lush.nvim", lazy = q },
        { "folke/tokyonight.nvim", lazy = q },
        { "rebelot/kanagawa.nvim", lazy = q },
        { "marko-cerovac/material.nvim", lazy = q },
        { "EdenEast/nightfox.nvim", lazy = q },
        { "yorumicolors/yorumi.nvim", lazy = q },
        { "scottmckendry/cyberdream.nvim", lazy = q },
        { "sainnhe/gruvbox-material", lazy = q },
        { "aktersnurra/no-clown-fiesta.nvim", lazy = q },
        { "datsfilipe/vesper.nvim", lazy = q },
        { "rafi/awesome-vim-colorschemes", lazy = q },
        { "zenbones-theme/zenbones.nvim", lazy = q },
        { "Yagua/nebulous.nvim", lazy = q },
        { "ramojus/mellifluous.nvim", lazy = q },
        { "metalelf0/jellybeans-nvim", lazy = q },
        { "Verf/deepwhite.nvim", lazy = q },
        { "kdheepak/monochrome.nvim", lazy = q },
        { "vague2k/vague.nvim", lazy = q },
        { "metalelf0/black-metal-theme-neovim", lazy = q },
        { "lunarvim/horizon.nvim", lazy = q },
        { "andersevenrud/nordic.nvim", lazy = q },
        { "oxfist/night-owl.nvim", lazy = q },
        { "slugbyte/lackluster.nvim", lazy = q },
        { "zootedb0t/citruszest.nvim", lazy = q },
        { "e-ink-colorscheme/e-ink.nvim", lazy = q },
        { "luisiacc/gruvbox-baby", lazy = q },
        { "catppuccin/nvim", name = "catppuccin", lazy = q },
        { "rose-pine/neovim", name = "rose-pine", lazy = q },
        { "nyoom-engineering/oxocarbon.nvim", lazy = q },
        { "bluz71/vim-moonfly-colors", lazy = q },
        { "bluz71/vim-nightfly-colors", lazy = q },
        { "jacoborus/tender.vim", lazy = q },
        { "savq/melange-nvim", lazy = q },
        { "rmehri01/onenord.nvim", lazy = q },
        { "olivercederborg/poimandres.nvim", lazy = q },
        { "xero/miasma.nvim", lazy = q },
        { "dgox16/oldworld.nvim", lazy = q },
        { "ficd0/ashen.nvim", lazy = q },
        { "water-sucks/darkrose.nvim", lazy = q },
        { "uhs-robert/oasis.nvim", lazy = q },
        { "casedami/neomodern.nvim", lazy = q },
        { "paulfrische/reddish.nvim", lazy = q },
        { "nikolvs/vim-sunbather", lazy = q },
        { "tiesen243/vercel.nvim", lazy = q },
        { "srcery-colors/srcery-vim", lazy = q },
        { "marekh19/meowsoot.nvim", lazy = q },
        { "hyperb1iss/silkcircuit", lazy = q },
        { "zitrocode/carvion.nvim", lazy = q },
        { "thallada/farout.nvim", lazy = q },
        { "vossenwout/guts.nvim", lazy = q },
        { "ZhiWei-Ou/grayveil.nvim", lazy = q },
        { "yonatan-perel/lake-dweller.nvim", lazy = q },
        { "0x-ximon/acario.nvim", lazy = q },
        { "ankushbhagats/pastel.nvim", lazy = q },
        { "ember-theme/nvim", lazy = q },
        { "craftzdog/solarized-osaka.nvim", lazy = q },
        { "AlexvZyl/nordic.nvim", lazy = q },
        { "navarasu/onedark.nvim", lazy = q },
        { "Mofiqul/vscode.nvim", lazy = q },
        { "Mofiqul/dracula.nvim", lazy = q },
        { "xiantang/darcula-dark.nvim", lazy = q },
        { "nvimdev/oxocarbon.nvim", lazy = q },
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
