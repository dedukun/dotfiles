""""""""
" Maps

" Remap 'Y' to stay the same as other commands
map Y y$

" Set map leader
let mapleader=","

" Remove all spaces at the end of lines
nnoremap <leader>cc  :%s/\s\+$//ge<CR>

" Toggle Syntastic [WIP]
nnoremap <leader>s  :call SyntasticToggle()<CR>

" vimgrep maps
" nnoremap <leader>f  :noautocmd grep -s <cword> **/* --include={*.c,*.h,*.py,*.java}<CR>
" nnoremap <leader>F  :call MultipleFileSearch("")<left><left>

" create section header
nnoremap <leader>h  :call CreateSectionHeader("")<left><left>

" Build tags file
nnoremap <leader>t :!ctags -R .<CR>
nnoremap <leader>T :call GenerateTags()<CR>

" Toggle Goyo
nnoremap <leader>g :call GoyoToggle()<CR>
nnoremap <leader>G :Goyo<CR>

" clear highlights
nnoremap <leader>n :noh<CR>

" toogle number
nnoremap <leader>N :call ToggleNumber()<CR>

" File Explorer
nnoremap <leader>m :call ToggleNERDTree()<CR>

" Refresh the buffer and NERDTree
nnoremap <leader>r :call RefreshBufferAndNERDTree()<CR>

" Remap split windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remap go back to file
" <C-~> didn't seem to work as a replacement for <C-^>)
nnoremap gb <C-^>

" Search for under under cursor in multiple files
nnoremap gr :noautocmd rep <cword> *<CR>
nnoremap Gr :noautocmd rep <cword> %:p:h/*<CR>
nnoremap gR :noautocmd rep '\b<cword>\b' *<CR>
nnoremap GR :noautocmd rep '\b<cword>\b' %:p:h/*<CR>

" Remap ^W_w to zoomwin
nnoremap <C-w>w :ZoomWinTabToggle<CR>

" neosnippet
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

if USE_COC
  " Coc
  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)
  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)
  " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
endif

""""""""
" Commands

" Reverse order of lines
" source: https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl

command! -buffer -nargs=1 CreateSectionHeader :call CreateSectionHeader(<args>)
