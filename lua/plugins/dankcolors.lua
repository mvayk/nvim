return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#10131c',
				base01 = '#10131c',
				base02 = '#8f9c9f',
				base03 = '#8f9c9f',
				base04 = '#ebfbff',
				base05 = '#f6fdff',
				base06 = '#f6fdff',
				base07 = '#f6fdff',
				base08 = '#ff82ac',
				base09 = '#ff82ac',
				base0A = '#72e3ff',
				base0B = '#8bff96',
				base0C = '#b4f0ff',
				base0D = '#72e3ff',
				base0E = '#8be8ff',
				base0F = '#8be8ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8f9c9f',
				fg = '#f6fdff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#72e3ff',
				fg = '#10131c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8f9c9f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#b4f0ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#8be8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#72e3ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#72e3ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#b4f0ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#8bff96',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#ebfbff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#ebfbff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8f9c9f',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
