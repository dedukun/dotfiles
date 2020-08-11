""""""""""""""""""""
" Plugins Settings

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist=['help', 'diff']
let g:better_whitespace_ctermcolor='DarkRed'

" Airline settings
if !exists('g:vscode')
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_theme = 'bubblegum'
endif

" netrw
let g:netrw_winsize = 20

" Number
if !exists('g:vscode')
  let g:numbers_exclude = ['tagbar', 'help', 'nerdtree', 'split-term']
endif

" vimtex
if !exists('g:vscode')
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_method = 'zathura'
  let g:tex_flavor = 'latex'
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

" polyglot
if !exists('g:vscode')
  let g:polyglot_disabled = ['latex', 'i3']
endif

" editorconfig
let g:EditorConfig_exclude_patterns = ['scp://.\*', 'suda://.\*', 'term://.\*']

" vim-commentary
autocmd FileType matlab setlocal commentstring=\%\ %s
autocmd FileType dosini setlocal commentstring=#\ %s
autocmd FileType markdown setlocal commentstring=<!--%s-->
autocmd FileType gdscript3 setlocal commentstring=#\ %s
autocmd FileType GDScript setlocal commentstring=#\ %s
autocmd FileType sxhkdrc setlocal commentstring=#\ %s

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

" editorconfig
if !exists('g:vscode')
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
endif
