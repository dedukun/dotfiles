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
		barbar = true,
		cmp = true,
		dap = {
			enabled = true,
			enable_ui = true,
		},
		fidget = true,
		gitsigns = true,
		lsp_trouble = true,
		lsp_saga = true,
		mason = true,
		mini = false,
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
		notify = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		rainbow_delimiters = true,
		which_key = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

vim.cmd.colorscheme("catppuccin")
