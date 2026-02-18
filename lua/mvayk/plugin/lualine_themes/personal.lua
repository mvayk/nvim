local M = {}

function load()
    require('lualine').setup {
        options = {
            theme = "auto",
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = process_sections {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'error' },
                    diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
                },
                {
                    'diagnostics',
                    source = { 'nvim' },
                    sections = { 'warn' },
                    diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
                },
                { 'filename', file_status = false, path = 1 },
                { modified, color = { bg = colors.red } },
                {
                    '%w',
                    cond = function()
                        return vim.wo.previewwindow
                    end,
                },
                {
                    '%r',
                    cond = function()
                        return vim.bo.readonly
                    end,
                },
                {
                    '%q',
                    cond = function()
                        return vim.bo.buftype == 'quickfix'
                    end,
                },
            },
            lualine_c = {},
            lualine_x = { },
            lualine_y = { search_result, 'filetype' },
            lualine_z = { '%l:%c', '%p%%/%L' },
        },
        inactive_sections = {
            lualine_c = { '%f %y %m' },
            lualine_x = {},
        },
    }
end

return M
