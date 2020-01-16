"""""""""""
" Plugins

call plug#begin('~/.vim/plugged')
" General
Plug 'troydm/zoomwintab.vim'                   "zoom in and out off a split window
Plug 'myusuf3/numbers.vim'                     "set relativenumber or number depending of the current mode
Plug 'bronson/vim-trailing-whitespace'         "show whitespaces at the end of lines in red
Plug 'lambdalisue/suda.vim'                    "edit root flies
Plug 'lifepillar/vim-gruvbox8'                 "colorscheme
Plug 'vimlab/split-term.vim'                   "better terminal
Plug 'nelstrom/vim-visual-star-search'         "visual search with * and #
Plug 'wellle/targets.vim'                      "more text objects ', . ; : + - = ~ _ * # / | \ & $'
Plug 'yuratomo/w3m.vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Autocomplete & snippets
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

" Misc
Plug 'junegunn/goyo.vim'                       "distraction free
Plug 'vim-airline/vim-airline'                 "status/tabline
Plug 'vim-airline/vim-airline-themes'          "status line themes
Plug 'frazrepo/vim-rainbow'                    "brackets color
Plug 'scrooloose/nerdtree'                     "file explorer
Plug 'sbdchd/neoformat'                        "autoformatter
Plug 'thinca/vim-quickrun'                     "run temporary code with QuickRun
Plug 'vim-scripts/DoxygenToolkit.vim'          "doxygen helper
Plug 'godlygeek/tabular'                       "tabular (required by vim-markdown)
Plug 'psliwka/vim-smoothie'                    "smoth scrolling with ^D,^U,^F,^B

" Syntax
Plug 'vim-syntastic/syntastic'                 "syntax checker
Plug 'myint/syntastic-extras'                  "syntastic extras
Plug 'lervag/vimtex'                           "latex support
Plug 'nikvdp/ejs-syntax'                       "ejs syntax
Plug 'PotatoesMaster/i3-vim-syntax'            "i3 config file syntax
Plug 'gisphm/vim-gitignore'                    "gitignore syntax
Plug 'datsun240z/bitbake.vim'                  "bitbake syntax
Plug 'sheerun/vim-polyglot'                    "a collection of syntaxes
Plug 'plasticboy/vim-markdown'                 "markdown syntax and other stuff
Plug 'calviken/vim-gdscript3'                  "GDScript syntax
Plug 'neomutt/neomutt.vim'                     "neomutt syntax

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
Plug 'tpope/vim-fugitive'                      "git plugin
call plug#end()
