""""""""""""""""""""
" General Settings

filetype plugin indent on
syntax enable                    "enable syntax highlighting

set hidden
set autoindent                   "indent at the same level of the previous line
set autoread                     "automatically read a file changed outside of vim
set nocompatible                 "less vi compatibility
set termguicolors                "number of colors
set tabstop=4                    "tabs are 4 spaces
set shiftwidth=4                 "spaces used in auto indenting
set expandtab                    "replace tabs with spaces
set mouse=a                      "enable mouse
set tw=0                         "maximum width of text that is being inserted
set cursorline                   "set a line where the cursor is
set showcmd                      "show commands in the lower right corner
set showmatch                    "show matching brackets/parentthesis
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
set encoding=UTF-8               "add support for utf-8 encoding
set noundofile                   "don't create .un~ file for persistent undo
set nobackup                     "CoC -> some servers have issues with backup files, see #649.
set nowritebackup
set wildmode=longest,list,full   "do a partial complete first
set wildmenu                     "command-line completion in enhanced mode
set spelllang=en,pt              "languages for spell checker
set complete=.,w,b,u,t,i,kspell  "complete options
set completeopt=menu,menuone,noselect
set noshowmode                   "don't show message if in Insert mode or other (vim-airline already does it)
set updatetime=300
set shortmess+=c                 "don't give |ins-completion-menu| messages.
set signcolumn=yes               "show the signcolumn
" set list

" Change the directory where temporary files are stored
set backupdir=~/.config/nvim/.backup//
set directory=~/.config/nvim/.backup//

" Tags files default locations
set tags=tags,./tags

"set color scheme
try
    let g:gruvbox_flat_style="dark"
    colorscheme gruvbox-flat
catch /^Vim\%((\a\+)\)\=:E185/
    " do nothing
endtry

if has('nvim')
    let g:python_host_prog = '/home/dedukun/.virtualenvs/vim-python2/bin/python2'
    let g:python3_host_prog = '/home/dedukun/.virtualenvs/vim/bin/python'
endif

" Change cursor shape depending of the mode
if has('nvim')
    " only needed in nvim 0.1.7 or older
    if !has('nvim-0.1.7')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    endif
else
    let &t_SI = "\<Esc>[6 q"
    let &t_EI = "\<Esc>[2 q"
    let &t_SR = "\<Esc>[4 q"
endif

" set .S syntax
autocmd BufNewFile,BufRead *.S set syntax=c | set ft=c

" Disable automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable maximum text width and spell check for some files
autocmd FileType tex set tw=200 | set spell
autocmd FileType gitcommit set tw=100 | set spell
autocmd FileType markdown set tw=100 | set spell

" Check for autoread
augroup checktime
    autocmd!
    if !has("gui_running")
        autocmd FocusGained     * silent! checktime
        autocmd BufEnter        * silent! checktime
    endif
augroup end

" Delete bash 'edit-and-execute-command' (C-xC-e, or, if vi-mode enabled, <Esc>v) temporary file when opening it
"
" Case: When using bash 'edit-and-execute-command', if you open the mode with nothing on the command-line,
" and after writing something you quit without saving, the temporary script will not run, as the file doesn't
" exists in the system. However, when starting this mode with something already in the command-line, the
" temporary script file will be created an saved in the system automatically, so even if you leave the mode
" without saving it, the command that was originally in the command-line will still run.
" Fix: The autocmd's bellow deletes the temporary file when vim starts reading it to the buffer, so the script needs
" to be saved before it is executed.
augroup del_bash_tmp_script
    autocmd FileChangedShell /tmp/bash-fc.* execute
    autocmd BufRead /tmp/bash-fc.* !rm %
augroup end

" Sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,rust setlocal foldmethod=syntax foldlevel=99
