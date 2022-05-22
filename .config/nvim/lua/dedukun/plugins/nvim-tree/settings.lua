local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
	return
end

vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
	lsp = {
		hint = "",
		info = "",
		warning = "",
		error = "",
	},
}

nvim_tree.setup({
	filters = {
		dotfiles = true
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
})

-- auto close when tree is the last window
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
