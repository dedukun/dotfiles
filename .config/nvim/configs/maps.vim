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
nnoremap <leader>m :Lexplore<CR>

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
nnoremap <C-p>  :FZF<CR>

" Fuzzy find for lines in files
nnoremap <leader><C-p>  :Ag<CR>

" CoC
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ COC_Check_Back_Space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" snippets maps
imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Use K to show documentation in preview window.
nnoremap <silent> K  :call COC_Show_Documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

""""""""
" Commands

" Reverse order of lines
" source: https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl

command! -nargs=1 CreateSectionHeader call CreateSectionHeader(<f-args>)
