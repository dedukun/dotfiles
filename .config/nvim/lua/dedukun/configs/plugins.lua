local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PackerBootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-----------------
		-- General
		-----------------
		-- show whitespaces at the end of lines in red
		use("ntpeters/vim-better-whitespace")
		-- visual search with * and #
		use("bronson/vim-visual-star-search")
		-- smooth scrolling with ^D,^U,^F,^B
		use("karb94/neoscroll.nvim")

		if vim.fn.exists("g:vscode") == 0 then
			-- set relativenumber or number when it makes sense
			use("jeffkreeftmeijer/vim-numbertoggle")
			-- zoom in and out off a split window
			use("troydm/zoomwintab.vim")
			-- edit root flies
			use("lambdalisue/suda.vim")
			-- colorscheme
			use("eddyekofo94/gruvbox-flat.nvim")
			-- terminal
			use("akinsho/toggleterm.nvim")
		end

		-----------------
		-- Treesitter
		-----------------
		if vim.fn.exists("g:vscode") == 0 then
			use({
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
			})
			-- brackets color
			use("p00f/nvim-ts-rainbow")
			-- set the commentstring option based on the cursor location
			use("JoosepAlviste/nvim-ts-context-commentstring")
			-- auto close and auto rename html tag
			use("windwp/nvim-ts-autotag")
			-- spell checker for Neovim powered by tree-sitter
			use("lewis6991/spellsitter.nvim")
			-- annotation toolkit
			use("danymat/neogen")
		end

		-----------------
		-- Extra Syntax
		-----------------
		if vim.fn.exists("g:vscode") == 0 then
			-- dart
			use("dart-lang/dart-vim-plugin")
			-- sxhkdrc
			use("baskerville/vim-sxhkdrc")
			-- systemd
			use("wgwoods/vim-systemd-syntax")
			-- bitbake
			use("kergoth/vim-bitbake")
		end

		-----------------
		-- Utils
		-----------------
		-- all the lua functions i don't want to write twice.
		use("nvim-lua/plenary.nvim")
		-- make mapping and commands more manageable in lua
		use("b0o/mapx.nvim")
		-- null-ls
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
		if vim.fn.exists("g:vscode") == 0 then
			use("nvim-lua/popup.nvim")
			-- speed up loading Lua modules in Neovim to improve startup time.
			use("lewis6991/impatient.nvim")
		end

		-----------------
		-- Misc
		-----------------
		-- horizontal movement helper
		use("unblevable/quick-scope")
		-- extended increment/decrement
		use("monaqa/dial.nvim")
		if vim.fn.exists("g:vscode") == 0 then
			-- status/tabline
			use({
				"nvim-lualine/lualine.nvim",
				requires = {
					-- for file icons
					{ "kyazdani42/nvim-web-devicons" },
					-- active lsp clients from the $/progress endpoint
					{ "arkav/lualine-lsp-progress" },
					-- status line component that shows context of the current cursor position in file
					{ "SmiteshP/nvim-gps" },
				},
			})
			-- formatter
			use("sbdchd/neoformat")
			-- ANSI color converter
			use("powerman/vim-plugin-AnsiEsc")
			-- color name highlighter
			use({ "RRethy/vim-hexokinase", run = "make hexokinase" })
			-- fuzzy finder
			use({
				"nvim-telescope/telescope.nvim",
				requires = {
					{ "nvim-lua/plenary.nvim" },
					{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				},
			})
			-- show git diffs in file
			use({
				"lewis6991/gitsigns.nvim",
				requires = {
					"nvim-lua/plenary.nvim",
				},
			})
			-- show keybindings when timed out
			use("folke/which-key.nvim")
			-- show indentation level
			use("lukas-reineke/indent-blankline.nvim")
			-- highlight and search for todo comments like TODO, HACK, BUG
			use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
			-- file explorer
			use({
				"kyazdani42/nvim-tree.lua",
				requires = {
					-- file icon
					"kyazdani42/nvim-web-devicons",
				},
			})
			-- highlight, navigate, and operate on sets of matching text
			use("andymass/vim-matchup")
			-- comments
			use("numToStr/Comment.nvim")
			-- light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
			use("tami5/lspsaga.nvim")
			-- debug adapter protocol client implementation
			use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
			-- pretty list for showing diagnostics
			use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
			-- see crates versions in rust
			use({
				"saecki/crates.nvim",
				requires = { "nvim-lua/plenary.nvim" },
			})
			--  simple and opinionated NeoVim plugin for switching between windows in the current tab page
			use("https://gitlab.com/yorickpeterse/nvim-window")
			-- fix neovim CursorHold and CursorHoldI autocmd
			use("antoinemadec/FixCursorHold.nvim")
			-- better/faster folds
			use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
			-- disable background colors
			use({ "xiyaowong/nvim-transparent" })
			-- tab bar
			use({
				"romgrk/barbar.nvim",
				requires = { "kyazdani42/nvim-web-devicons" },
			})
		end

		-----------------
		-- Completion
		-----------------
		if vim.fn.exists("g:vscode") == 0 then
			use({
				"neovim/nvim-lspconfig",
				requires = {
					--seamlessly install LSP servers locally
					"williamboman/nvim-lsp-installer",
					--show function signature when you type
					"ray-x/lsp_signature.nvim",
					--cmp LSP source
					"hrsh7th/cmp-nvim-lsp",
				},
			})
			--snippet engine
			use({
				"L3MON4D3/LuaSnip",
				--default snippets
				requires = { "rafamadriz/friendly-snippets" },
			})
			--auto completion
			use({
				"hrsh7th/nvim-cmp",
				requires = {
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
					--cmp dap source
					"rcarriga/cmp-dap",
				},
			})
		end

		-----------------
		-- Text objects
		-----------------
		--more text objects ', . ; : + - = ~ _ * # / | \ & $'
		use("wellle/targets.vim")
		--create custom text objects easily
		use("kana/vim-textobj-user")
		--text object for indents
		use("kana/vim-textobj-indent")
		--text object for C-like functions
		use("kana/vim-textobj-function")

		-----------------
		-- Tpope
		-----------------
		--maps to delete, change,... around brackets,... (eg. cs'<q>)
		use("tpope/vim-surround")
		--more repeatable plugins
		use("tpope/vim-repeat")
		--automatically adjust tab size intelligently
		use("tpope/vim-sleuth")

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PackerBootstrap then
			require("packer").sync()
		end
	end,
	config = {
		-- Move to lua dir so impatient.nvim can cache it
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	},
})
