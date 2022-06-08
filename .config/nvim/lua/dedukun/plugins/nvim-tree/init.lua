local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
	return
end

nvim_tree.setup({
	filters = {
		dotfiles = true,
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	renderer = {
		special_files = { },
	},
})

-- auto close when tree is the last window
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})
