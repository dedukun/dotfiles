local present, crates = pcall(require, "crates")
if not present then
	return
end

crates.setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
})
