local present, lualine = pcall(require, "lualine")
if not present then
	return
end

local gps = require("nvim-gps")

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox-flat",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				source = diff_source,
				diff_color = {
					added = { fg = "#859D63", gui = "bold" },
					modified = { fg = "#CB8237", gui = "bold" },
					removed = { fg = "#C35C56", gui = "bold" },
				},
			},
		},
		lualine_c = {
			"filename",
			{ gps.get_location, cond = gps.is_available },
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			{
				"lsp_progress",
				display_components = { "lsp_client_name", "spinner", { "title", "percentage" } },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			},
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
