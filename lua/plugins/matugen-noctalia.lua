return {
  dir = "/home/mvayk/.local/state/noctalia/community-templates/neovim/matugen-noctalia",
  name = "matugen-noctalia",
  lazy = false,
  priority = 1000,
  config = function()
    require("matugen-noctalia").setup()
  end,
}
