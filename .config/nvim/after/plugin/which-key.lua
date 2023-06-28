local present, which = pcall(require, "which-key")
if not present then
	return
end

which.setup({})
