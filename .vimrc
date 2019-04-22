"""""""""""
" Plugins
call plug#begin('~/.vim/plugged')
Plug 'myusuf3/numbers.vim'              "set relativenumber or number depending of the current mode
Plug 'vim-airline/vim-airline'          "status/tabline
Plug 'vim-airline/vim-airline-themes'   "status line themes
Plug 'bronson/vim-trailing-whitespace'  "show whitespaces at the end of lines in red
Plug 'lervag/vimtex'                    "latex support
Plug 'vimwiki/vimwiki'                  "markdown (and other stuff)
Plug 'nikvdp/ejs-syntax'                "ejs syntax
Plug 'vim-syntastic/syntastic'          "syntax checker
Plug 'PotatoesMaster/i3-vim-syntax'     "i3 config file syntax
Plug 'Valloric/YouCompleteMe'           "auto complete
Plug 'tpope/vim-surround'               "map to delete, change,... around brackets,... (eg. cs'<q>)
Plug 'kana/vim-textobj-user'            "create custom text objects easily
Plug 'kana/vim-textobj-function'        "text object for functions
Plug 'kana/vim-textobj-indent'          "text object for indents
call plug#end()

""""""""""""""""""""
" General Settings
syntax on                        "enable syntax highlighting

set nocompatible                 "less vi compatibility
set t_Co=256                     "number of colors
set tabstop=4                    "tabs are 4 spaces
set shiftwidth=4                 "spaces used in auto indenting
set expandtab                    "replace tabs with spaces
set mouse=a                      "enable mouse
set tw=100                       "maximum width of text that is being inserted
set cursorline                   "set a line where the cursor is
set showcmd                      "show commands in the lower right corner
set number                       "set number of the lines in the side
set hlsearch                     "highlight all search matches
set backspace=2                  "make backspace work in insert mode
set splitbelow splitright        "make splits open at the bottom and right
set bg=dark
if has('unnamedplus')            "use special register '*' or '+' for all
    set clipboard=unnamedplus    "yank, delete, ...
else
    set clipboard=unnamed
endif
set encoding=utf-8               "add support for utf-8 encoding
set noundofile                   "don't create .un~ file for persistent undo
set wildmenu                     "command-line completion in enhanced mode

" Change the directory where temporary files are stored
set backupdir=~/.vim/.backup//
set directory=~/.vim/.backup//

colorscheme Tomorrow-Night-Eighties "set color scheme

" Change cursor shape depending of the mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable maximum text width for this files
autocmd FileType tex set tw=0

""""""""
" Maps

"set map leader
let mapleader=","

"remove all spaces at the end of lines
nnoremap <leader>cc  :%s/\s\+$//ge<cr>

" Toggle Syntastic
nnoremap <leader>s  :SyntasticToggleMode <bar> lclose<cr>

" Remap split windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Build tags file
nnoremap <leader>t :!ctags -R .<cr>
nnoremap <leader>T :!ctags -R ..<cr>

""""""""""""""""""""
" Plugins Settings

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" YouCompleteMe
" Turn off error highlights
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
