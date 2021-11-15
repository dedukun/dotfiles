local present, lualine = pcall(require, "lualine")
if not present then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox-flat",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "netrw", "NvimTree" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				diff_color = {
					added = "#859D63",
					modified = "#CB8237",
					removed = "#C35C56",
				},
			},
		},
		lualine_c = {
			"filename",
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			'lsp_progress'
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
