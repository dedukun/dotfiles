""""""""
" Maps

" Remap 'Y' to stay the same as other commands
map Y y$

" Vmap for maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Set map leader
let mapleader=","

" Remove all spaces at the end of lines
nnoremap <leader>cc  :StripWhitespace<CR>

" vimgrep maps
" nnoremap <leader>f  :noautocmd grep -s <cword> **/* --include={*.c,*.h,*.py,*.java}<CR>
" nnoremap <leader>F  :call MultipleFileSearch("")<left><left>

" create section header
nnoremap <leader>h  :CreateSectionHeader<space>

" Build tags file
nnoremap <leader>t :!ctags -R .<CR>
nnoremap <leader>T :call GenerateTags()<CR>

" clear highlights
nnoremap <leader>n :noh<CR>

" toogle number
nnoremap <leader>N :call ToggleNumber()<CR>

" File Explorer
" nnoremap <leader>m :Lexplore<CR>
nnoremap <leader>m :NvimTreeToggle<CR>

" Remap split windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remap go back to file
" <C-~> didn't seem to work as a replacement for <C-^>)
nnoremap gb <C-^>

" Search for under under cursor in multiple files
nnoremap gr :noautocmd vimgrep <cword> *<CR>
nnoremap Gr :noautocmd vimgrep <cword> %:p:h/*<CR>
nnoremap gR :noautocmd vimgrep '\b<cword>\b' *<CR>
nnoremap GR :noautocmd vimgrep '\b<cword>\b' %:p:h/*<CR>

" Remap ^W_w to zoomwin
nnoremap <C-w>w :ZoomWinTabToggle<CR>

" Fuzzy find for files
nnoremap <C-p>  :Telescope find_files<CR>

" Fuzzy find for lines in files
nnoremap <leader><C-p>  :Telescope live_grep<CR>

" show hover doc
nnoremap <silent> K :Lspsaga hover_doc<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

""""""""
" Commands

" Reverse order of lines
" source: https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl

command! -nargs=1 CreateSectionHeader call CreateSectionHeader(<f-args>)
