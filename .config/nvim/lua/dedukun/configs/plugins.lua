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
		use("nelstrom/vim-visual-star-search")
		-- smooth scrolling with ^D,^U,^F,^B
		use("karb94/neoscroll.nvim")

		-- if !exists('g:vscode')
		-- set relativenumber or number when it makes sense
		use("jeffkreeftmeijer/vim-numbertoggle")
		-- zoom in and out off a split window
		use("troydm/zoomwintab.vim")
		-- edit root flies
		use("lambdalisue/suda.vim")
		-- colorscheme
		use("eddyekofo94/gruvbox-flat.nvim")
		-- floating terminal
		use("numToStr/FTerm.nvim")
		-- endif

		-----------------
		-- Syntax
		-----------------
		-- if !exists('g:vscode')
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		-- dart
		use("dart-lang/dart-vim-plugin")
		-- sxhkdrc
		use("baskerville/vim-sxhkdrc")
		-- endif

		-----------------
		-- Misc
		-----------------
		--horizontal movement helper
		use("unblevable/quick-scope")
		--extended increment/decrement
		use("monaqa/dial.nvim")
		-- if !exists('g:vscode')
		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")
		-- WARNING: May need to comment to be able to install/uninstall stuff with lspinstall
		--status/tabline
		use("nvim-lualine/lualine.nvim")
		-- active lsp clients from the $/progress endpoint
		use("arkav/lualine-lsp-progress")
		--brackets color
		use("p00f/nvim-ts-rainbow")
		--formatter
		use("sbdchd/neoformat")
		--ANSI color converter
		use("powerman/vim-plugin-AnsiEsc")
		--editorconfig plugin
		use("editorconfig/editorconfig-vim")
		--color name highlighter
		use("norcalli/nvim-colorizer.lua")
		--nvim for web browser
		use({
			"glacambre/firenvim",
			run = function()
				vim.fn["firenvim#install"](0)
			end,
		})
		--fuzzy finder
		use("nvim-telescope/telescope.nvim")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		--show git diffs in file
		use("lewis6991/gitsigns.nvim")
		--set the commentstring option based on the cursor location
		use("JoosepAlviste/nvim-ts-context-commentstring")
		--show keybindings when timed out
		use("folke/which-key.nvim")
		--show indentation level
		use("lukas-reineke/indent-blankline.nvim")
		--highlight and search for todo comments like TODO, HACK, BUG
		use("folke/todo-comments.nvim")
		--markdown previewer
		use({
			"dedukun/markdown-preview.nvim",
			run = "cd app && yarn install",
			cmd = "MarkdownPreview",
			branch = "linux-browser-args",
		})
		--for file icons
		use("kyazdani42/nvim-web-devicons")
		--file explorer
		use("kyazdani42/nvim-tree.lua")
		--highlight, navigate, and operate on sets of matching text
		use("andymass/vim-matchup")
		--comments
		use("numToStr/Comment.nvim")
		--auto close and auto rename html tag
		use("windwp/nvim-ts-autotag")
		--spell checker for Neovim powered by tree-sitter
		use("lewis6991/spellsitter.nvim")
		--light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
		use("tami5/lspsaga.nvim")
		--annotation toolkit
		use({
			"danymat/neogen",
			config = function()
				require("neogen").setup({
					enabled = true,
				})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		})
		--speed up loading Lua modules in Neovim to improve startup time.
		use("lewis6991/impatient.nvim")
		--  make mapping and commands more manageable in lua
		use("b0o/mapx.nvim")
		-- endif

		-----------------
		-- Completion
		-----------------
		-- if !exists('g:vscode')
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use("ray-x/lsp_signature.nvim")
		--snippet engine
		use("L3MON4D3/LuaSnip")
		--vscode-like pictograms for neovim lsp completion items
		use("onsails/lspkind-nvim")
		--default snippets
		use("rafamadriz/friendly-snippets")
		--auto completion
		use("hrsh7th/nvim-cmp")
		--cmp system path source
		use("hrsh7th/cmp-path")
		--cmp neovim lua API source
		use("hrsh7th/cmp-nvim-lua")
		--cmp LSP source
		use("hrsh7th/cmp-nvim-lsp")
		--cmp buffer
		use("hrsh7th/cmp-buffer")
		--cmp for vim's cmdline
		use("hrsh7th/cmp-cmdline")
		--cmp LuaSnip source
		use("saadparwaiz1/cmp_luasnip")
		-- endif

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
		--maps for multiple uses
		use("tpope/vim-unimpaired")
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
