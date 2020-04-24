""""""""""""""""""""
" Plugins Settings

" Airline settings
if !exists('g:vscode')
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_theme = 'bubblegum'
endif

" Syntastic settings
if !exists('g:vscode')
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
endif

" Number
if !exists('g:vscode')
  let g:numbers_exclude = ['tagbar', 'help', 'nerdtree', 'split-term']
endif

" vimtex
if !exists('g:vscode')
  let g:vimtex_latexmk_progname = 'nvr'
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_method = 'zathura'
endif

" rainbow
if !exists('g:vscode')
  au FileType c,cpp,objc,objcpp,tex call rainbow#load()
  let g:rainbow_guifgs = ['DarkOrange3', 'DarkGoldenrod3', 'LightGoldenrod3']
  let g:rainbow_load_separately = [
        \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
        \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
        \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
        \ ]
endif

" NERDTree
if !exists('g:vscode')
  " closes NERDTree if only NERDTree is open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " show hidden files
  let NERDTreeShowHidden=1
  let g:WebDevIconsOS = 'Linux'
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:DevIconsEnableFolderExtensionPatternMatching = 1
  let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
  let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
  let NERDTreeNodeDelimiter = "\u263a" " smiley face
endif

" polyglot
if !exists('g:vscode')
  let g:polyglot_disabled = ['latex', 'i3']
endif

" editor
" let g:EditorConfig_exclude_patterns = ['scp://.\*', 'suda://.\*', 'term://.\*']

" deoplete
if !exists('g:vscode')
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
endif

" vim-commentary
autocmd FileType matlab setlocal commentstring=\%\ %s
autocmd FileType dosini setlocal commentstring=#\ %s
autocmd FileType markdown setlocal commentstring=<!--%s-->
autocmd FileType gdscript3 setlocal commentstring=#\ %s
autocmd FileType GDScript setlocal commentstring=#\ %s

" markdown previewer
if !exists('g:vscode')
  " specify browser to open preview page
  " default: ''
  let g:mkdp_browser = 'firefox --private-window'
  " a custom vim function name to open preview page
  " this function will receive url as param
  " default is empty
  let g:mkdp_browserfunc = ''
  " options for markdown render
  " mkit: markdown-it options for render
  " katex: katex options for math
  " uml: markdown-it-plantuml options
  " maid: mermaid options
  " disable_sync_scroll: if disable sync scroll, default 0
  " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
  "   middle: mean the cursor position alway show at the middle of the preview page
  "   top: mean the vim top viewport alway show at the top of the preview page
  "   relative: mean the cursor position alway show at the relative positon of the preview page
  " hide_yaml_meta: if hide yaml metadata, default is 1
  " sequence_diagrams: js-sequence-diagrams options
  let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {},
      \ 'flowchart_diagrams': {}
      \ }
endif

" quick-scope
if !exists('g:vscode')
  " Trigger a highlight in the appropriate direction when pressing these keys:
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
endif
