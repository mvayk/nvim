return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#141318',
				base01 = '#141318',
				base02 = '#9c99a5',
				base03 = '#9c99a5',
				base04 = '#f3efff',
				base05 = '#faf8ff',
				base06 = '#faf8ff',
				base07 = '#faf8ff',
				base08 = '#ff9fb3',
				base09 = '#ff9fb3',
				base0A = '#d4c6ff',
				base0B = '#a5ffb8',
				base0C = '#e8e1ff',
				base0D = '#d4c6ff',
				base0E = '#dbd0ff',
				base0F = '#dbd0ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9c99a5',
				fg = '#faf8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#d4c6ff',
				fg = '#141318',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9c99a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e8e1ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#dbd0ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#d4c6ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#d4c6ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#e8e1ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb8',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#f3efff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#f3efff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9c99a5',
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
