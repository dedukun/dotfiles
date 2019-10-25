"""""""""""
" Plugins

call plug#begin('~/.vim/plugged')
" General
Plug 'ahonn/resize.vim'                        "resize split screens
Plug 'troydm/zoomwintab.vim'                   "zoom in and out off a split window
Plug 'myusuf3/numbers.vim'                     "set relativenumber or number depending of the current mode
Plug 'bronson/vim-trailing-whitespace'         "show whitespaces at the end of lines in red
Plug 'lambdalisue/suda.vim'                    "edit root flies
Plug 'morhetz/gruvbox'                         "colorscheme
Plug 'vimlab/split-term.vim'                   "better terminal

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx'                  "c-lang completer
Plug 'deoplete-plugins/deoplete-jedi'          "python completer
Plug 'artur-shaik/vim-javacomplete2'           "java completer
Plug 'ervandew/supertab'                       "use tab for autocomplete
Plug 'SirVer/ultisnips'                        "snippet engine
Plug 'honza/vim-snippets'                      "large snippets collection
Plug 'vim-scripts/DoxygenToolkit.vim'          "doxygen helper

" Misc
Plug 'junegunn/goyo.vim'                       "distraction free
Plug 'vim-airline/vim-airline'                 "status/tabline
Plug 'vim-airline/vim-airline-themes'          "status line themes
Plug 'frazrepo/vim-rainbow'                    "brackets color
Plug 'scrooloose/nerdtree'                     "file explorer
Plug 'Chiel92/vim-autoformat'                  "autoformatter
Plug 'thinca/vim-quickrun'                     "run temporary code with QuickRun
"Plug 'editorconfig/editorconfig-vim'           "project configs

" Syntax
Plug 'vim-syntastic/syntastic'                 "syntax checker
Plug 'myint/syntastic-extras'                  "syntastic extras
Plug 'lervag/vimtex'                           "latex support
Plug 'nikvdp/ejs-syntax'                       "ejs syntax
Plug 'PotatoesMaster/i3-vim-syntax'            "i3 config file syntax
Plug 'gisphm/vim-gitignore'                    "gitignore syntax
Plug 'plasticboy/vim-markdown'                 "markdown syntax
Plug 'datsun240z/bitbake.vim'                  "yocto syntax
Plug 'sheerun/vim-polyglot'                    "a collection of syntaxes

" Text objects
Plug 'kana/vim-textobj-user'                   "create custom text objects easily
Plug 'kana/vim-textobj-indent'                 "text object for indents
Plug 'kana/vim-textobj-function'               "text object for C-like functions

" Tpope
Plug 'tpope/vim-surround'                      "maps to delete, change,... around brackets,... (eg. cs'<q>)
Plug 'tpope/vim-unimpaired'                    "maps for multiple uses
Plug 'tpope/vim-repeat'                        "more repeatable plugins
Plug 'tpope/vim-commentary'                    "easy comments
call plug#end()
