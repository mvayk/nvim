require("mvayk")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    import = "mvayk.plugin",
})

local function anti_background()
    local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "SignColumn",
        "LineNr",
        "CursorLineNr",
        "FoldColumn",
        "EndOfBuffer",
        "DiagnosticSignError",
        "DiagnosticSignWarn",
        "DiagnosticSignInfo",
        "DiagnosticSignHint",
        "LspCodeActionSign",

        "FloatBorder",
        -- "Pmenu",
        -- "PmenuSel",
        -- "PmenuSbar",
        -- "PmenuThumb",
        "WinSeparator",
        "StatusLine",
        "StatusLineNC",


        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeFloatBorder",
        "NeoTreeTitleBar",
        "NeoTreeWinSeparator",
        "NeoTreeFileName",
        "NeoTreeDirectoryName",
        "NeoTreeRootName",
        "NeoTreeGitUntracked",
        "NeoTreeGitModified",

        "lualine_a_normal",
        "lualine_b_normal",
        "lualine_c_normal",
        "lualine_x_normal",
        "lualine_y_normal",
        "lualine_z_normal",
        "lualine_a_insert",
        "lualine_b_insert",
        "lualine_c_insert",
        "lualine_x_insert",
        "lualine_y_insert",
        "lualine_z_insert",

        "SnacksPicker",
        "SnacksPickerBorder",
        "SnacksPickerTitle",
        "SnacksPickerInput",
        "SnacksPickerList",
        "SnacksPickerPreview",
        "SnacksPickerPrompt",
        "SnacksPickerDir",
        "SnacksPickerMatch",
        "SnacksPickerIcon",
        --"SnacksPickerCursorLine",
        --"SnacksPickerListCursorLine",
        "SnacksDashboard",
        "SnacksDashboardIcon",
        "SnacksDashboardDesc",
        "SnacksDashboardKey",
        "SnacksDashboardTitle",

        "SnacksNotifierInfo",
        "SnacksNotifierWarn",
        "SnacksNotifierError",
        "SnacksNotifierDebug",
        "SnacksNotifierTrace",
        "SnacksNotifierBorder",
    }

    for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end

    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#cccccc" })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffaa00" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#cccccc" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#cccccc" })

    -- nixos shenanigans cause this to be undercurled for some reason probably
    --vim.api.nvim_set_hl(0, "@lsp.type.unresolvedReference", { undercurl = false })
end

local theme_file = vim.fn.stdpath("data") .. "/last_theme.lua"

local ok, _err = pcall(dofile, theme_file)
if not ok then
    print("Creating theme file")
    vim.o.background = "dark"
    vim.cmd([[colorscheme rose-pine]])
end

local function anti_anti_background()
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            anti_background()
            local file = io.open(theme_file, "w")
            if file then
                file:write(string.format([[
                vim.o.background = "%s"
                vim.cmd.colorscheme("%s")
                ]], vim.o.background, vim.g.colors_name))
                file:close()
                anti_background()
            end
            anti_background()
        end
    })

    vim.keymap.set("n", "<leader>tb", function()
        if vim.o.background == "dark" then
            vim.o.background = "light"
            vim.notify("Toggled Light")
            anti_background()
        else
            vim.o.background = "dark"
            vim.notify("Toggled Dark")
            anti_background()
        end
        anti_background()
    end, { desc = "Toggle background" })

    anti_background()
end

local function normal_background()
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
            local file = io.open(theme_file, "w")
            if file then
                file:write(string.format([[
                vim.o.background = "%s"
                vim.cmd.colorscheme("%s")
                ]], vim.o.background, vim.g.colors_name))
                file:close()
            end
        end
    })

    vim.keymap.set("n", "<leader>tb", function()
        if vim.o.background == "dark" then
            vim.o.background = "light"
            vim.notify("Toggled Light")
        else
            vim.o.background = "dark"
            vim.notify("Toggled Dark")
        end
    end, { desc = "Toggle background" })
end


--// use terminal colors
--vim.o.termguicolors = false
--vim.o.background = 'dark'  -- or 'light'
--vim.cmd([[colorscheme tokyobones]])

anti_anti_background()
