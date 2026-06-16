-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

local settings = require("mvayk.settings")

local function install_colorschemes()
    return {
        { "rktjmp/lush.nvim",                          lazy = true },
        { "folke/tokyonight.nvim",                     lazy = true },
        { "rebelot/kanagawa.nvim",                     lazy = true },
        { "marko-cerovac/material.nvim",               lazy = true },
        { "EdenEast/nightfox.nvim",                    lazy = true },
        { "yorumicolors/yorumi.nvim",                  lazy = true },
        { "scottmckendry/cyberdream.nvim",             lazy = true },
        { "sainnhe/gruvbox-material",                  lazy = true },
        { "aktersnurra/no-clown-fiesta.nvim",          lazy = true },
        { "datsfilipe/vesper.nvim",                    lazy = true },
        { "rafi/awesome-vim-colorschemes",             lazy = true },
        { "zenbones-theme/zenbones.nvim",              lazy = true },
        { "Yagua/nebulous.nvim",                       lazy = true },
        { "ramojus/mellifluous.nvim",                  lazy = true },
        { "metalelf0/jellybeans-nvim",                 lazy = true },
        { "Verf/deepwhite.nvim",                       lazy = true },
        { "kdheepak/monochrome.nvim",                  lazy = true },
        { "vague2k/vague.nvim",                        lazy = true },
        { "metalelf0/black-metal-theme-neovim",        lazy = true },
        { "lunarvim/horizon.nvim",                     lazy = true },
        { "andersevenrud/nordic.nvim",                 lazy = true },
        { "oxfist/night-owl.nvim",                     lazy = true },
        { "slugbyte/lackluster.nvim",                  lazy = true },
        { "zootedb0t/citruszest.nvim",                 lazy = true },
        { "e-ink-colorscheme/e-ink.nvim",              lazy = true },
        { "luisiacc/gruvbox-baby",                     lazy = true },
        { "catppuccin/nvim",       name = "catppuccin", lazy = true },
        { "rose-pine/neovim",      name = "rose-pine",  lazy = true },
        { "nyoom-engineering/oxocarbon.nvim",          lazy = true },
        { "bluz71/vim-moonfly-colors",                 lazy = true },
        { "bluz71/vim-nightfly-colors",                lazy = true },
        { "jacoborus/tender.vim",                      lazy = true },
        { "savq/melange-nvim",                         lazy = true },
        { "rmehri01/onenord.nvim",                     lazy = true },
        { "olivercederborg/poimandres.nvim",           lazy = true },
        { "xero/miasma.nvim",                          lazy = true },
        { "dgox16/oldworld.nvim",                      lazy = true },
        { "ficd0/ashen.nvim",                          lazy = true },
        { "water-sucks/darkrose.nvim",                 lazy = true },
        { "uhs-robert/oasis.nvim",                     lazy = true },
        { "casedami/neomodern.nvim",                   lazy = true },
        { "paulfrische/reddish.nvim",                  lazy = true },
        { "nikolvs/vim-sunbather",                     lazy = true },
        { "tiesen243/vercel.nvim",                     lazy = true },
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
