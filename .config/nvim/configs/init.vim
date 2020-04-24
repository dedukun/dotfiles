"""""""""""
" Plugins

call plug#begin('~/.vim/plugged')
" General
Plug 'bronson/vim-trailing-whitespace'         "show whitespaces at the end of lines in red
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

" Autocomplete & snippets
if !exists('g:vscode')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete-clangx'                  "c-lang completer
    Plug 'deoplete-plugins/deoplete-jedi'          "python completer
    Plug 'artur-shaik/vim-javacomplete2'           "java completer
    Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    Plug 'Shougo/neco-vim'                         "vim completer
    Plug 'ervandew/supertab'                       "use tab for autocomplete
    Plug 'Shougo/neosnippet.vim'                   "snippets support
    Plug 'Shougo/neosnippet-snippets'              "standard snippets repo
endif

" Misc
if !exists('g:vscode')
  Plug 'vim-airline/vim-airline'                 "status/tabline
  Plug 'vim-airline/vim-airline-themes'          "status line themes
  Plug 'junegunn/goyo.vim'                       "distraction free
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'frazrepo/vim-rainbow'                    "brackets color
  Plug 'sbdchd/neoformat'                        "autoformatter
  Plug 'thinca/vim-quickrun'                     "run temporary code with QuickRun
  Plug 'vim-scripts/DoxygenToolkit.vim'          "doxygen helper
  Plug 'godlygeek/tabular'                       "tabular (required by vim-markdown)
  Plug 'dedukun/markdown-preview.nvim', { 'do': 'cd app & yarnpkg install', 'branch': 'linux-browser-args' } "markdown previewer
  " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarnpkg install' } "markdown previewer
  Plug 'powerman/vim-plugin-AnsiEsc'             "ANSI color converter
  Plug 'daeyun/vim-matlab', { 'do': ':UpdateRemotePlugins' }
  Plug 'unblevable/quick-scope'                  "horizontal movement helper
endif

" Syntax
if !exists('g:vscode')
  Plug 'vim-syntastic/syntastic'                 "syntax checker
  Plug 'myint/syntastic-extras'                  "syntastic extras
  Plug 'lervag/vimtex'                           "latex support
  Plug 'nikvdp/ejs-syntax'                       "ejs syntax
  Plug 'PotatoesMaster/i3-vim-syntax'            "i3 config file syntax
  Plug 'gisphm/vim-gitignore'                    "gitignore syntax
  Plug 'datsun240z/bitbake.vim'                  "bitbake syntax
  Plug 'sheerun/vim-polyglot'                    "a collection of syntaxes
  Plug 'calviken/vim-gdscript3'                  "GDScript syntax
  Plug 'neomutt/neomutt.vim'                     "neomutt syntax
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

" NerdTree
if !exists('g:vscode')
  Plug 'scrooloose/nerdtree'                     "file explorer
  Plug 'Xuyuanp/nerdtree-git-plugin'             "git plugin for nerdtree
  " Plug 'ryanoasis/vim-devicons'                  "extra icons for nerdtree
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif
call plug#end()
