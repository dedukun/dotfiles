syntax on                        "enable syntax highlighting

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
set bg=dark
if has('unnamedplus')            "use special register '*' or '+' for all
    set clipboard+=unnamedplus   " yank, delete, ...
else
    set clipboard+=unnamed
endif

colorscheme Tomorrow-Night-Eighties "set color scheme


""""""""""
" New maps
let mapleader=","                "set map leader

"remove all spaces at the end of lines
map <leader>cc :%s/\s\+$//ge<cr>


""""""""""
" Plugins
call plug#begin('~/.vim/plugged')
Plug 'myusuf3/numbers.vim'              "set relativenumber or number depending of the current mode
Plug 'tpope/vim-surround'               "map to delete, change,... arround brakets, ...  (eg. cs'<q>)
Plug 'tpope/vim-fugitive'               "git wrapper for vim (eg. :Git)
Plug 'tpope/vim-eunuch'                 "shell commands in vim
Plug 'nathanaelkane/vim-indent-guides'  "show indent levels
Plug 'vim-airline/vim-airline'          "status/tabline
Plug 'vim-airline/vim-airline-themes'   " airline themes
Plug 'junegunn/vim-easy-align'          "easy to use alignment plugin
Plug 'bronson/vim-trailing-whitespace'  "show whitespaces at the end of lines in red
Plug 'Valloric/YouCompleteMe'           "auto complete
call plug#end()


"""""""""""""""""
" Plugs Setup

" Start interactive EasyAlign in visual mode (eg. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (eg. gaip)
nmap ga <Plug>(EasyAlign)

