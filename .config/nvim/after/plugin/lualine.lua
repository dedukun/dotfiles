local present, lualine = pcall(require, "lualine")
if not present then
	return
end

local navic = require("nvim-navic")

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
			{
				"navic",
				-- Component specific options
				color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
				-- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
				-- Setting it to "static" will perform a adjustment once when the component is being setup. This should
				--   be enough when the lualine section isn't changing colors based on the mode.
				-- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
				--   the current section.

				navic_opts = nil, -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			{
				"lsp_progress",
				display_components = { "lsp_client_name", "spinner", { "title", "percentage" } },
				spinner_symbols = {
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				},
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
