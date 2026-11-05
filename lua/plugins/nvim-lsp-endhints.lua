local enabled = true

if enabled then
    if vim.g.neovide then
        return {
            "chrisgrieser/nvim-lsp-endhints",
            enabled = true,
            event = "LspAttach",
            opts = {}, -- required, even if empty
            config = function()
                if require("settings").neovide_ancient then
                    require("lsp-endhints").setup({
                        icons = {
                            type = "@",
                            parameter = "@",
                            offspec = "@", -- hint kind not defined in official LSP spec
                            unknown = "@", -- hint kind is nil
                        },
                    })
                else
                    require("lsp-endhints").setup({})
                end
            end,
        }
    end
end

return {}
