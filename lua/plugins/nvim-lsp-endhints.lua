local enabled = true
if enabled then
    if vim.g.neovide then
        return {
            "chrisgrieser/nvim-lsp-endhints",
            enabled = true,
            event = "LspAttach",
            opts = {}, -- required, even if empty
        }
    end
end

return {}
