local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
	return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
	view = {
		relativenumber = true
	},
	filters = {
		dotfiles = true,
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	renderer = {
		special_files = {},
	},
})

-- auto close when tree is the last window
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})
