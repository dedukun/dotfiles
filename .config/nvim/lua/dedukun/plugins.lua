local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-----------------
	-- General
	-----------------
	-- show whitespaces at the end of lines in red
	"johnfrankmorgan/whitespace.nvim",
	-- visual search with * and #
	"bronson/vim-visual-star-search",
	-- set relativenumber or number when it makes sense
	{ "sitiom/nvim-numbertoggle", cond = vim.fn.exists("g:vscode") == 0 },
	-- zoom in and out off a split window
	{ "troydm/zoomwintab.vim", cond = vim.fn.exists("g:vscode") == 0 },
	-- edit root flies
	{ "lambdalisue/suda.vim", cond = vim.fn.exists("g:vscode") == 0 },
	-- colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		cond = vim.fn.exists("g:vscode") == 0,
		priority = 1000,
		config = function()
			require("dedukun.plugins.catppuccin")
		end,
	},
	-- terminal
	{ "akinsho/toggleterm.nvim", cond = vim.fn.exists("g:vscode") == 0 },
	--
	-- { "HiPhish/rainbow-delimiters.nvim", cond = vim.fn.exists("g:vscode") == 0 },

	-----------------
	-- Treesitter
	-----------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- function context
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- set the commentstring option based on the cursor location
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- auto close and auto rename html tag
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- annotation toolkit
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cond = vim.fn.exists("g:vscode") == 0,
	},

	-- -----------------
	-- Extra Syntax
	-----------------
	-- dart
	{
		"dart-lang/dart-vim-plugin",
		ft = "dart",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- sxhkdrc
	{
		"baskerville/vim-sxhkdrc",
		ft = "sxhkdrc",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- systemd
	{
		"wgwoods/vim-systemd-syntax",
		ft = "sytemd",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- bitbake
	{
		"kergoth/vim-bitbake",
		ft = "bitbake",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- kitty
	{
		"fladson/vim-kitty",
		ft = "kitty",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- hyprland
	{
		"theRealCarneiro/hyprland-vim-syntax",
		ft = "hypr",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- rofi
	{
		"Fymyte/rasi.vim",
		ft = "rasi",
		cond = vim.fn.exists("g:vscode") == 0,
	},

	-----------------
	-- Utils
	-----------------
	-- -- null-ls
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("dedukun.plugins.null_ls")
	-- 	end,
	-- 	dependencies = { "nvim-lua/plenary.nvim", "jayp0521/mason-null-ls.nvim" },
	-- },
	-- -- nvim-lint
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- },
	-- formatter
	{
		"mhartington/formatter.nvim",
	},

	-----------------
	-- Misc
	-----------------
	-- horizontal movement helper
	{ "ggandor/flit.nvim", dependencies = {
		"ggandor/leap.nvim",
		"tpope/vim-repeat",
	} },
	-- extended increment/decrement
	"monaqa/dial.nvim",
	-- status/tabline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			-- for file icons
			{ "nvim-tree/nvim-web-devicons" },
			-- status line component that shows context of the current cursor position in file
			{ "SmiteshP/nvim-navic" },
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- ANSI color converter
	{ "powerman/vim-plugin-AnsiEsc", cond = vim.fn.exists("g:vscode") == 0 },
	-- color name highlighter
	{ "NvChad/nvim-colorizer.lua", cond = vim.fn.exists("g:vscode") == 0 },
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"debugloop/telescope-undo.nvim",
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- show git diffs in file
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- show keybindings when timed out
	{ "folke/which-key.nvim", cond = vim.fn.exists("g:vscode") == 0 },
	-- show indentation level
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, cond = vim.fn.exists("g:vscode") == 0 },
	-- highlight and search for todo comments like TODO, HACK, BUG
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			-- file icon
			"nvim-tree/nvim-web-devicons",
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- highlight, navigate, and operate on sets of matching text
	-- {
	-- 	"andymass/vim-matchup",
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("dedukun.plugins.matchup")
	-- 	end,
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	cond = vim.fn.exists("g:vscode") == 0,
	-- },
	-- comments
	{
		"numToStr/Comment.nvim",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		cmd = "Lspsaga",
		config = function()
			require("dedukun.plugins.lspsaga")
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- debug adapter protocol client implementation
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"jayp0521/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/cmp-dap",
		},
		config = function()
			require("dedukun.plugins.nvim-dap")
		end,
	},
	-- pretty list for showing diagnostics
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cond = vim.fn.exists("g:vscode") == 0,
	},
	-- see crates versions in rust
	{
		"Saecki/crates.nvim",
		ft = "toml",
		config = function()
			require("dedukun.plugins.crates")
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		cond = vim.fn.exists("g:vscode") == 0,
	},
	--  simple and opinionated NeoVim plugin for switching between windows in the current tab page
	{ "yorickpeterse/nvim-window", cond = vim.fn.exists("g:vscode") == 0 },
	-- disable background colors
	{ "xiyaowong/transparent.nvim", cond = vim.fn.exists("g:vscode") == 0 },
	-- tab bar
	-- {
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	cond = vim.fn.exists("g:vscode") == 0,
	-- },
	-- Neovim setup for init.lua and plugin development
	{ "folke/neodev.nvim", cond = vim.fn.exists("g:vscode") == 0 },
	-- Delete buffers
	{ "ojroques/nvim-bufdel" },
	-- LSP progress
	{ "j-hui/fidget.nvim" },
	--
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = {
		"nvim-lua/plenary.nvim",
	} },
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			notification = true,
			hint = true,
		},
	},
	-- {
	-- 	"huggingface/llm.nvim",
	-- 	opts = {
	-- 		api_token = nil,
	-- 		model = "http://127.0.0.1:11434",
	-- 		lsp = {
	-- 			bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
	-- 		},
	-- 		tokenizer = {
	-- 			repository = "codellama/CodeLlama-13b-hf",
	-- 		},
	-- 	},
	-- },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre ~/Projects/**.md",
		--   "BufNewFile ~/GBT/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Projects",
				},
				{
					name = "work",
					path = "~/GBT",
				},
			},

			-- see below for full list of options 👇
		},
		config = function()
			vim.opt.conceallevel = 1
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-----------------
	-- Completion
	-----------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			--seamlessly install LSP servers locally
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			--show function signature when you type
			"ray-x/lsp_signature.nvim",
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},
	--snippet engine
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		--default snippets
		dependencies = { "rafamadriz/friendly-snippets" },
		cond = vim.fn.exists("g:vscode") == 0,
	},
	--auto completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			--vscode-like pictograms for neovim lsp completion items
			"onsails/lspkind-nvim",
			--cmp system path source
			"hrsh7th/cmp-path",
			--cmp neovim lua API source
			"hrsh7th/cmp-nvim-lua",
			--cmp LSP source
			"hrsh7th/cmp-nvim-lsp",
			--cmp buffer
			"hrsh7th/cmp-buffer",
			--cmp for vim's cmdline
			"hrsh7th/cmp-cmdline",
			--cmp LuaSnip source
			"saadparwaiz1/cmp_luasnip",
		},
		cond = vim.fn.exists("g:vscode") == 0,
	},

	-----------------
	-- Tpope
	-----------------
	--maps to delete, change,... around brackets,... (eg. cs'<q>)
	"tpope/vim-surround",
	--more repeatable plugins
	"tpope/vim-repeat",
	--automatically adjust tab size intelligently
	"tpope/vim-sleuth",
}, {
	ui = {
		border = "rounded",
	},
})
