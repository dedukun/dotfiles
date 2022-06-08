local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

treesitter.setup({
	ensure_installed = "all",   -- A list of parser names, or "all"
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = { "#CD6600", "#CD950C", "#CDBE70" }, -- table of hex strings
	},
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
