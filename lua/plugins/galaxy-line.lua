return {
    "NTBBloodbath/galaxyline.nvim",
    enabled = false,
    lazy = false,
    config = function()
        require("galaxyline.themes.eviline")
    end,

    requires = { "kyazdani42/nvim-web-devicons", opt = true },
}
