-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

return {
    "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    "marko-cerovac/material.nvim",
    "EdenEast/nightfox.nvim",
    "yorumicolors/yorumi.nvim",
    "scottmckendry/cyberdream.nvim",
    "sainnhe/gruvbox-material",
    "rose-pine/neovim",
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

    config = function()
        require("gruvbox").setup({
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })
    end
}
