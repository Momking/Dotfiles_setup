return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f1417',
				base01 = '#0f1417',
				base02 = '#929a9e',
				base03 = '#929a9e',
				base04 = '#eff9ff',
				base05 = '#f8fcff',
				base06 = '#f8fcff',
				base07 = '#f8fcff',
				base08 = '#ff9fbd',
				base09 = '#ff9fbd',
				base0A = '#a7ddff',
				base0B = '#a5ffb0',
				base0C = '#d0edff',
				base0D = '#a7ddff',
				base0E = '#b6e3ff',
				base0F = '#b6e3ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#929a9e',
				fg = '#f8fcff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#a7ddff',
				fg = '#0f1417',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#929a9e' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d0edff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#b6e3ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#a7ddff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#a7ddff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#d0edff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb0',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff9ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff9ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#929a9e',
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
