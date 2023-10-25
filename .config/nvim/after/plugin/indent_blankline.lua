local present, indent_blankline = pcall(require, "ibl")
if not present then
	return
end

indent_blankline.setup({
	scope = { enabled = false },
})
