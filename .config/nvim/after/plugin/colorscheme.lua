local present, catppuccin = pcall(require, "catppuccin")
if not present then
	return
end

catppuccin.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = {
		-- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = false, -- show the '~' characters after the end of buffers
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = false,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		barbar = true,
		ts_rainbow2 = true,
		notify = true,
		which_key = true,
		lsp_trouble = true,
		treesitter = true,
		treesitter_context = true,
		mason = true,
		markdown = true,
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.cmd.colorscheme("catppuccin")
