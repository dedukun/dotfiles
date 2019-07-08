"""""""""""
" Plugins
call plug#begin('~/.vim/plugged')
" General
Plug 'ahonn/resize.vim'                 "resize split screens
Plug 'troydm/zoomwintab.vim'            "zoom in and out off a split window
Plug 'myusuf3/numbers.vim'              "set relativenumber or number depending of the current mode
Plug 'bronson/vim-trailing-whitespace'  "show whitespaces at the end of lines in red
Plug 'vim-scripts/DoxygenToolkit.vim'   "doxygen autogenerator
Plug 'lambdalisue/suda.vim'             "edit root flies


" Misc
Plug 'junegunn/goyo.vim'                "distraction free
Plug 'Valloric/YouCompleteMe'           "auto complete
Plug 'vim-airline/vim-airline'          "status/tabline
Plug 'vim-airline/vim-airline-themes'   "status line themes
Plug 'morhetz/gruvbox'                  "colorscheme

" Syntax
Plug 'vim-syntastic/syntastic'          "syntax checker
Plug 'myint/syntastic-extras'           "syntastic extras
Plug 'lervag/vimtex'                    "latex support
Plug 'vimwiki/vimwiki'                  "markdown (and other stuff)
Plug 'nikvdp/ejs-syntax'                "ejs syntax
Plug 'PotatoesMaster/i3-vim-syntax'     "i3 config file syntax

" Text objects
Plug 'kana/vim-textobj-user'            "create custom text objects easily
Plug 'kana/vim-textobj-indent'          "text object for indents
Plug 'kana/vim-textobj-function'        "text object for C-like functions

" Tpope
Plug 'tpope/vim-surround'               "maps to delete, change,... around brackets,... (eg. cs'<q>)
Plug 'tpope/vim-unimpaired'             "maps for multiple uses
Plug 'tpope/vim-repeat'                 "more repeatable plugins
call plug#end()

""""""""""""""""""""
" General Settings
filetype plugin indent on
syntax enable                    "enable syntax highlighting

set nocompatible                 "less vi compatibility
set termguicolors                "number of colors
set tabstop=4                    "tabs are 4 spaces
set shiftwidth=4                 "spaces used in auto indenting
set expandtab                    "replace tabs with spaces
set mouse=a                      "enable mouse
set tw=0                         "maximum width of text that is being inserted
set cursorline                   "set a line where the cursor is
set showcmd                      "show commands in the lower right corner
set number                       "set number of the lines in the side
set hlsearch                     "highlight all search matches
set ignorecase                   "searches are case insensitive
set smartcase                    "search will be case sensitive if it contains an uppercase letter
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
set wildmode=longest,list,full   "do a partial complete first
set wildmenu                     "command-line completion in enhanced mode

if has('nvim')
    let g:python_host_prog  = '/usr/bin/python2.7'
    let g:python3_host_prog = '/usr/local/bin/python3.6'
endif

" Change the directory where temporary files are stored
set backupdir=~/.vim/.backup//
set directory=~/.vim/.backup//

" Tags files default locations
set tags=./tags,./TAGS,tags,TAGS,../tags,../TAGS

" Add additional tags depending on file type
"autocmd FileType c   set tags+=~/.vim/tags/clang_tags,~/.vim/tags/arduino_tags
"autocmd FileType cpp set tags+=~/.vim/tags/clang_tags,~/.vim/tags/arduino_tags,~/.vim/tags/cpp_tag
"autocmd BufRead call LoadTags

" Change cursor shape depending of the mode
if has('nvim')
    " only needed in nvim 0.1.7 or before
    if !has('nvim-0.1.7')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    endif
else
    let &t_SI = "\<Esc>[6 q"
    let &t_EI = "\<Esc>[2 q"
    let &t_SR = "\<Esc>[4 q"
endif

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable maximum text width for tex files
autocmd FileType tex set tw=200

" Delete bash 'edit-and-execute-command' (C-xC-e, or, if vi-mode enabled, <Esc>v) temporary file when opening it
"
" Case: When using bash 'edit-and-execute-command', if you open the mode with nothing on the command-line,
" and after writing something you quit without saving, the temporary script will not run, as the file doesn't
" exists in the system. However, when starting this mode with something already in the command-line, the
" temporary script file will be created an saved in the system automatically, so even if you leave the mode
" without saving it, the command that was originally in the command-line will still run.
" Result: The autocmd's bellow delete the temporary file when vim starts reading it to the buffer, so the script needs
" to be saved before it is executed.
augroup del_bash_tmp_script
    autocmd FileChangedShell /tmp/bash-fc.* execute
    autocmd BufRead /tmp/bash-fc.* !rm %
augroup end

"set color scheme
colorscheme gruvbox

""""""""
" Maps

" Set map leader
let mapleader=","

" Remove all spaces at the end of lines
nnoremap <leader>cc  :%s/\s\+$//ge<CR>

" Toggle Syntastic
nnoremap <leader>s  :call SyntasticToggle()

" Send through scp
nnoremap <leader>h  :call SCP()<CR>

" vimgrep maps
nnoremap <leader>f  :grep -s <cword> ** --include={*.c,*.h}<CR>
nnoremap <leader>F  :call SearchInMultipleFiles("")<Left><Left>

" Build tags file
nnoremap <leader>t :!ctags -R .<CR>
nnoremap <leader>T :!ctags -R ..<CR>

" Toggle Goyo
nnoremap <leader>g :call GoyoToggle()<CR>
nnoremap <leader>G :Goyo<CR>

" Clear highligths
nnoremap <leader>n :noh<CR>

" Repeat last command-line command
noremap <leader>r @:<CR>

" Remap split windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Search for under under cursor in multiple files
nnoremap gr :grep <cword> *<CR>
nnoremap Gr :grep <cword> %:p:h/*<CR>
nnoremap gR :grep '\b<cword>\b' *<CR>
nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

" Remap ^W_w to zoomwin
nnoremap <C-w>w :ZoomWinTabToggle<CR>

"""""""""""""""""
" Vim Functions

function GoyoToggle()
    if &number ==# 1
        NumbersDisable
        Goyo 70%
    else
        NumbersEnable
        Goyo!
        set number
    endif
endfunction

function LoadTags()
    let &tags = '~/.vim/tags/clang_tags,~/.vim/tags/arduino_tags'
    if &filetype == 'c'
        set tags+= '~/.vim/tags/clang_tags,~/.vim/tags/arduino_tags'
    elseif &filetype == 'cpp'
        set tags+= '~/.vim/tags/clang_tags,~/.vim/tags/arduino_tags,~/.vim/tags/cpp_tag'
    endif
endfunction

"""""""
" WIP "
"""""""
function SCP()
    echo "[WIP] SCP send"

endfunction

function SyntasticToggle()
    echom b:syntastic_mode
    "SyntasticToggleMode | lclose<CR>
endfunction

function SearchInMultipleFiles(search)
    grep -s a:search ** --exclude={tags,compile_commands.json} --exclude-dir={_*}
endfunction

" args *
" argsdo

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
let g:syntastic_c_checkers = ['check']
let g:syntastic_cpp_checkers = ['check']
let g:syntastic_make_checkers = ['gnumake']
let g:syntastic_javascript_checkers = ['json_tool']
let g:syntastic_json_checkers = ['json_tool']
let g:syntastic_python_checkers = ['pyflakes_with_warnings']

" YouCompleteMe
" Turn off error highlights
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion=1

" Number
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'help']

" vimtex
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
