""""""""
" Maps

" Vmap for maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Set map leader
let mapleader=","

" Remove all spaces at the end of lines
nnoremap <leader>cc  :StripWhitespace<CR>

" create section header
nnoremap <leader>h <cmd>lua require'dedukun.tools'.createHeader()<CR>

" Build tags file
nnoremap <leader>t :!ctags -R .<CR>
nnoremap <leader>T <cmd>lua require'dedukun.tools'.generateTags()<CR>

" clear highlights
nnoremap <leader>n :noh<CR>

" toogle number
nnoremap <leader>N :call ToggleNumber()<CR>

" File Explorer
nnoremap <leader>m :NvimTreeToggle<CR>

" Remap split windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remap go back to file
" <C-~> didn't seem to work as a replacement for <C-^>)
nnoremap gb <C-^>

" Remap ^W_w to zoomwin
nnoremap <C-w>w :ZoomWinTabToggle<CR>

" Fuzzy find for files
nnoremap <C-p>  <cmd>lua require('telescope.builtin').find_files()<cr>

" Fuzzy find for lines in files
nnoremap <leader><C-p>  <cmd>lua require('telescope.builtin').live_grep()<cr>

" Fuzzy find for files in the Neovim lua configurations
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({cwd="$HOME/.config/nvim/lua/dedukun"})<cr>

" make shift tab work in insert mode
inoremap <S-Tab> <C-d>

" Open/Close floating terminal
nnoremap <leader>F <cmd>lua require('FTerm').toggle()<cr>
tnoremap <leader>F <cmd>lua require('FTerm').toggle()<cr>

""""""""""""""""""""
" LSPsaga
" show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" documentation
nnoremap <leader>dd <cmd>lua require('neogen').generate()<cr>
nnoremap <leader>dc <cmd>lua require('neogen').generate({ type = 'class' })<cr>
nnoremap <leader>df <cmd>lua require('neogen').generate({ type = 'func' })<cr>
nnoremap <leader>dt <cmd>lua require('neogen').generate({ type = 'type' })<cr>

""""""""
" Commands

" Reverse order of lines
" source: https://vim.fandom.com/wiki/Reverse_order_of_lines
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1|nohl

command! -nargs=1 CreateSectionHeader lua require'dedukun.tools'.createHeader(<f-args>)
