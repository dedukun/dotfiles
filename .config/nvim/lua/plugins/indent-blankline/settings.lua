local present, indent_blankline = pcall(require, "indent_blankline")
if not present then
	return
end

indent_blankline.setup({
	char = "│",
	buftype_exclude = { "terminal" },
})
