--------------------
-- Plugins Settings

-- vim-better-whitespace
require("dedukun.plugins.vim-better-whitespace")

-- lualine
require("dedukun.plugins.lualine")

-- nvim tree
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.nvim-tree")
end

-- editorconfig
require("dedukun.plugins.editorconfig")

-- comment
require("dedukun.plugins.comment")

-- vim-matchup
require("dedukun.plugins.vim-matchup")

-- markdown previewer
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.markdown-previewer")
end

-- quick-scope
if vim.fn.exists("g:vscode") == 0 then
	require("dedukun.plugins.quick-scope")
end

-- neoformat
require("dedukun.plugins.neoformat")

-- firenvim
require("dedukun.plugins.firenvim")

-- treesitter
require("dedukun.plugins.treesitter")

-- lspinstall
require("dedukun.plugins.lsp")

-- colorizer
require("dedukun.plugins.colorizer")

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
