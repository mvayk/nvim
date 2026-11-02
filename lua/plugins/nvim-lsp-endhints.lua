local enabled = false
if enabled then
    if vim.g.neovide then
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
        vim.api.nvim_set_hl(0, "LspInlayHint", {
            bg = normal.bg or "NONE",
        })

        return {
            "chrisgrieser/nvim-lsp-endhints",
            enabled = true,
            event = "LspAttach",
            opts = {}, -- required, even if empty
        }
    end
end

return {}
