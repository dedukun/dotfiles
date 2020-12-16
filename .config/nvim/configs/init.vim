"""""""""""
" Plugins

call plug#begin('~/.config/nvim/plugged')
" General
Plug 'ntpeters/vim-better-whitespace'          "show whitespaces at the end of lines in red
Plug 'nelstrom/vim-visual-star-search'         "visual search with * and #
Plug 'wellle/targets.vim'                      "more text objects ', . ; : + - = ~ _ * # / | \ & $'
Plug 'psliwka/vim-smoothie'                    "smoth scrolling with ^D,^U,^F,^B
if !exists('g:vscode')
  Plug 'myusuf3/numbers.vim'                     "set relativenumber or number depending of the current mode
  Plug 'troydm/zoomwintab.vim'                   "zoom in and out off a split window
  Plug 'lambdalisue/suda.vim'                    "edit root flies
  Plug 'lifepillar/vim-gruvbox8'                 "colorscheme
  Plug 'vimlab/split-term.vim'                   "better terminal
endif

" CoC
if !exists('g:vscode')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Misc
if !exists('g:vscode')
  Plug 'vim-airline/vim-airline'                 "status/tabline
  Plug 'vim-airline/vim-airline-themes'          "status line themes
  Plug 'frazrepo/vim-rainbow'                    "brackets color
  Plug 'sbdchd/neoformat'                        "autoformatter
  Plug 'vim-scripts/DoxygenToolkit.vim'          "doxygen helper
  Plug 'powerman/vim-plugin-AnsiEsc'             "ANSI color converter
  Plug 'unblevable/quick-scope'                  "horizontal movement helper
  Plug 'qwertologe/nextval.vim'                  "better ^A and ^X
  Plug 'editorconfig/editorconfig-vim'           "editorconfig plugin
  Plug 'ap/vim-css-color'                        "color name highlighter
  " Plug 'daeyun/vim-matlab'                       "matlab support
endif

" Syntax
if !exists('g:vscode')
  Plug 'sheerun/vim-polyglot'                    "a collection of syntaxes
  Plug 'datsun240z/bitbake.vim'                  "bitbake syntax
  Plug 'nikvdp/ejs-syntax'                       "ejs syntax
  Plug 'PotatoesMaster/i3-vim-syntax'            "i3 config file syntax
  Plug 'neomutt/neomutt.vim'                     "neomutt syntax
  Plug 'gisphm/vim-gitignore'                    "gitignore syntax
  Plug 'habamax/vim-godot'                       "GDScript syntax
  Plug 'lervag/vimtex'                           "latex support
endif

" Text objects
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
  Plug 'tpope/vim-fugitive'                      "git plugin
endif
call plug#end()
