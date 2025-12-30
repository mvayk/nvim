-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

return {
    "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
    "marko-cerovac/material.nvim",
    "EdenEast/nightfox.nvim",
    "yorumicolors/yorumi.nvim",
    "scottmckendry/cyberdream.nvim",
    "sainnhe/gruvbox-material",
    "aktersnurra/no-clown-fiesta.nvim",
    "rafi/awesome-vim-colorschemes",
    "zenbones-theme/zenbones.nvim",
    "Yagua/nebulous.nvim",
    "ramojus/mellifluous.nvim",
    "metalelf0/jellybeans-nvim",
    "Verf/deepwhite.nvim",
    "kdheepak/monochrome.nvim",
    "vague2k/vague.nvim",
    "lunarvim/horizon.nvim",
    "andersevenrud/nordic.nvim",
    "oxfist/night-owl.nvim",
    "everviolet/nvim",
    "0xstepit/flow.nvim",
    "slugbyte/lackluster.nvim",
    "zootedb0t/citruszest.nvim",
    "e-ink-colorscheme/e-ink.nvim",
    "luisiacc/gruvbox-baby",
    "ellisonleao/gruvbox.nvim",
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    "rose-pine/neovim",
    config = function()
        require("rose-pine").setup {
            styles = {
                bold = true,
                italic = false,
                transparency = true,
                disable_background = true,
            }
        }
    end
}
