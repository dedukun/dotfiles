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
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = true,
	filter = {
		custom = {
			".git",
		},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
})
