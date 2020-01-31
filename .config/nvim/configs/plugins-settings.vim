""""""""""""""""""""
" Plugins Settings

" Airline settings
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme = 'bubblegum'

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
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

" Number
let g:numbers_exclude = ['tagbar', 'help', 'nerdtree', 'split-term']

" vimtex
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'

" rainbow
"au FileType c,cpp,objc,objcpp call rainbow#load()
let g:rainbow_active = 1
let g:rainbow_guifgs = ['DarkOrange3', 'DarkGoldenrod3', 'LightGoldenrod3']
let g:rainbow_load_separately = [
      \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
      \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
      \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
      \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
      \ ]

" NERDTree
" closes NERDTree if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" polyglot
let g:polyglot_disabled = ['latex', 'i3']

" editor
let g:EditorConfig_exclude_patterns = ['scp://.\*', 'suda://.\*', 'term://.\*']

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" deoplete tab-complete
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

" deoplete/Jedi
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#python_path = '/usr/bin/python'

" deoplete vimtex
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" This is old style (deprecated)
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" vim-commentary
autocmd FileType matlab setlocal commentstring=\%\ %s
autocmd FileType dosini setlocal commentstring=#\ %s
autocmd FileType markdown setlocal commentstring=<!--%s-->
