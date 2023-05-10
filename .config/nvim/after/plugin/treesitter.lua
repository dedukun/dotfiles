local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

treesitter.setup({
	ensure_installed = "all", -- A list of parser names, or "all"
	highlight = {
		enable = true,     -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
		query = {
			"rainbow-parens",
		},
		strategy = require("ts-rainbow").strategy.global,
	},
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
