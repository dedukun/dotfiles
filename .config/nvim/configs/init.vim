"""""""""""
" Plugins

call plug#begin('~/.config/nvim/plugged')
" General
Plug 'ntpeters/vim-better-whitespace'          "show whitespaces at the end of lines in red
Plug 'nelstrom/vim-visual-star-search'         "visual search with * and #
Plug 'psliwka/vim-smoothie'                    "smoth scrolling with ^D,^U,^F,^B
if !exists('g:vscode')
  Plug 'jeffkreeftmeijer/vim-numbertoggle'     "set relativenumber or number when it makes sense
  Plug 'troydm/zoomwintab.vim'                 "zoom in and out off a split window
  Plug 'lambdalisue/suda.vim'                  "edit root flies
  Plug 'lifepillar/vim-gruvbox8'               "colorscheme
  Plug 'vimlab/split-term.vim'                 "better terminal
endif

" Completion
if !exists('g:vscode')
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'hrsh7th/nvim-compe'
  Plug 'ray-x/lsp_signature.nvim'
endif

" Misc
Plug 'unblevable/quick-scope'                  "horizontal movement helper
Plug 'qwertologe/nextval.vim'                  "better ^A and ^X
if !exists('g:vscode')
  Plug 'vim-airline/vim-airline'               "status/tabline
  Plug 'vim-airline/vim-airline-themes'        "status line themes
  Plug 'luochen1990/rainbow'                   "brackets color
  Plug 'sbdchd/neoformat'                      "autoformatter
  Plug 'vim-scripts/DoxygenToolkit.vim'        "doxygen helper
  Plug 'powerman/vim-plugin-AnsiEsc'           "ANSI color converter
  Plug 'editorconfig/editorconfig-vim'         "editorconfig plugin
  Plug 'norcalli/nvim-colorizer.lua'           "color name highlighter
  " Plug 'daeyun/vim-matlab'                     "matlab support
  Plug 'junegunn/fzf.vim'
  Plug 'honza/vim-snippets'                    "add snippets
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } "nvim for web browser
  Plug 'Yggdroot/indentLine'                   "show identation level
  Plug 'airblade/vim-gitgutter'                "show git diffs in file
endif

" Syntax
if !exists('g:vscode')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'dart-lang/dart-vim-plugin'             "dart
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
