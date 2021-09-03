"""""""""""
" Plugins

call plug#begin('~/.config/nvim/plugged')
" General
Plug 'ntpeters/vim-better-whitespace'          "show whitespaces at the end of lines in red
Plug 'nelstrom/vim-visual-star-search'         "visual search with * and #
Plug 'karb94/neoscroll.nvim'                   "smoth scrolling with ^D,^U,^F,^B
if !exists('g:vscode')
  Plug 'jeffkreeftmeijer/vim-numbertoggle'     "set relativenumber or number when it makes sense
  Plug 'troydm/zoomwintab.vim'                 "zoom in and out off a split window
  Plug 'lambdalisue/suda.vim'                  "edit root flies
  Plug 'eddyekofo94/gruvbox-flat.nvim'         "colorscheme
endif

" Syntax
if !exists('g:vscode')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'dart-lang/dart-vim-plugin'             "dart
endif

" Misc
Plug 'unblevable/quick-scope'                  "horizontal movement helper
Plug 'qwertologe/nextval.vim'                  "better ^A and ^X
if !exists('g:vscode')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'hoob3rt/lualine.nvim'                  "status/tabline
  Plug 'p00f/nvim-ts-rainbow'                  "brackets color
  Plug 'sbdchd/neoformat'                      "autoformatter
  Plug 'vim-scripts/DoxygenToolkit.vim'        "doxygen helper
  Plug 'powerman/vim-plugin-AnsiEsc'           "ANSI color converter
  Plug 'editorconfig/editorconfig-vim'         "editorconfig plugin
  Plug 'norcalli/nvim-colorizer.lua'           "color name highlighter
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "nvim for web browser
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'                "fuzzy finder
  Plug 'lewis6991/gitsigns.nvim'                      "show git diffs in file
  Plug 'sindrets/diffview.nvim'                       "diff git files in vim
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'  "set the commentstring option based on the cursor location
  Plug 'folke/which-key.nvim'                         "show keybindings when timed out
  Plug 'lukas-reineke/indent-blankline.nvim'          "show identation level
  Plug 'mg979/vim-visual-multi', {'branch': 'master'} "code-like multiple cursors
  Plug 'folke/todo-comments.nvim'                     "highlight and search for todo comments like TODO, HACK, BUG
  Plug 'dedukun/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'branch': 'linux-browser-args' } "markdown previewer
  Plug 'kyazdani42/nvim-web-devicons'                 " for file icons
  Plug 'kyazdani42/nvim-tree.lua'                     "file explorer
  Plug 'andymass/vim-matchup'                         "highlight, navigate, and operate on sets of matching text
endif

" Completion
if !exists('g:vscode')
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'L3MON4D3/LuaSnip'                      "snippet engine
  Plug 'rafamadriz/friendly-snippets'          "default snippets
  Plug 'hrsh7th/nvim-cmp'                      "auto completion
  Plug 'onsails/lspkind-nvim'                  "vscode-like pictograms for neovim lsp completion items

  Plug 'hrsh7th/cmp-path'                      "cmp system path source
  Plug 'hrsh7th/cmp-nvim-lua'                  "cmp neovim lua API source
  Plug 'hrsh7th/cmp-nvim-lsp'                  "cmp LSP source
  Plug 'saadparwaiz1/cmp_luasnip'              "cmp LuaSnip source
endif

" Text objects
Plug 'wellle/targets.vim'                      "more text objects ', . ; : + - = ~ _ * # / | \ & $'
Plug 'kana/vim-textobj-user'                   "create custom text objects easily
Plug 'kana/vim-textobj-indent'                 "text object for indents
Plug 'kana/vim-textobj-function'               "text object for C-like functions

" Tpope
Plug 'tpope/vim-surround'                      "maps to delete, change,... around brackets,... (eg. cs'<q>)
Plug 'tpope/vim-unimpaired'                    "maps for multiple uses
Plug 'tpope/vim-repeat'                        "more repeatable plugins
Plug 'tpope/vim-commentary'                    "easy comments
Plug 'tpope/vim-sleuth'                        "automatically adjust tab size intelligently
if !exists('g:vscode')
  Plug 'tpope/vim-fugitive'                    "git plugin
endif
call plug#end()
