--------------------
-- Plugins Settings

-- nvim-web-devicons
require("dedukun.plugins.nvim-web-devicons")

-- vim-better-whitespace
require("dedukun.plugins.vim-better-whitespace")

-- lualine
require("dedukun.plugins.lualine")

-- nvim tree
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.nvim-tree")
end

-- comment
require("dedukun.plugins.comment")

-- vim-matchup
require("dedukun.plugins.vim-matchup")

-- quick-scope
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.quick-scope")
end

-- treesitter
require("dedukun.plugins.treesitter")

-- lsp
require("dedukun.plugins.lsp")

-- auto completion
require("dedukun.plugins.nvim-cmp")

-- luasnip
require("dedukun.plugins.luasnip")

-- gitsigns
require("dedukun.plugins.gitsigns")

-- which-key
require("dedukun.plugins.which-key")

-- neoscroll
require("dedukun.plugins.neoscroll")

-- indent-blankline
require("dedukun.plugins.indent-blankline")

-- todo-comments
require("dedukun.plugins.todo-comments")

-- dial
require("dedukun.plugins.dial")

-- spellsitter
require("dedukun.plugins.spellsitter")

-- lspsaga
require("dedukun.plugins.lspsaga")

-- neogen
require("dedukun.plugins.neogen")

-- trouble
require("dedukun.plugins.trouble")

-- crates
require("dedukun.plugins.crates")

-- toggleterm
require("dedukun.plugins.toggleterm")

-- nvim-gps
require("dedukun.plugins.nvim-gps")

-- nvim-window
require("dedukun.plugins.nvim-window")

-- -- nvim-dap
-- if vim.fn.exists("g:vscode") == 0 then
-- 	require("dedukun.plugins.nvim-dap")
-- end

-- nvim-ufo
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.nvim-ufo")
end

-- transparent
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.transparent")
end

-- barbar
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.barbar")
end

-- null-ls
require("dedukun.plugins.null-ls")

-- null-ls
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.colorizer")
end

-- null-ls
require("dedukun.plugins.neodev")
