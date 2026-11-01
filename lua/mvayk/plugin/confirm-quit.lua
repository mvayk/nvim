local enabled = vim.g.neovide

if enabled then
    return {
        "yutkat/confirm-quit.nvim",
        enabled = true,
        event = "CmdlineEnter",
        opts = {},
    }
end
