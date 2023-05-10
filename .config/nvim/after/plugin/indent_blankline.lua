local present, indent_blankline = pcall(require, "indent_blankline")
if not present then
	return
end

indent_blankline.setup({
	char = "│",
	filetype_exclude = {
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"man",
		"",
		"lsp-installer",
	},
	use_treesitter = true,
})
