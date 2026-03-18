return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#11131c',
				base01 = '#11131c',
				base02 = '#96a1a5',
				base03 = '#96a1a5',
				base04 = '#ecf9ff',
				base05 = '#f7fcff',
				base06 = '#f7fcff',
				base07 = '#f7fcff',
				base08 = '#ff88af',
				base09 = '#ff88af',
				base0A = '#78daff',
				base0B = '#90ff9c',
				base0C = '#b7ebff',
				base0D = '#78daff',
				base0E = '#90e0ff',
				base0F = '#90e0ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#96a1a5',
				fg = '#f7fcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#78daff',
				fg = '#11131c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#96a1a5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#b7ebff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#90e0ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#78daff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#78daff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#b7ebff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#90ff9c',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#ecf9ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#ecf9ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#96a1a5',
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
