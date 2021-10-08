""""""""""""""""""""
" Plugins Settings

" vim-better-whitespace
lua require "plugins.vim-better-whitespace"

" lualine
lua require "plugins.lualine"

" nvim tree
if !exists('g:vscode')
  lua require "plugins.nvim-tree"
endif

" vimtex
if !exists('g:vscode')
  lua require "plugins.vimtex"
endif

" editorconfig
lua require "plugins.editorconfig"

" vim-commentary
lua require "plugins.vim-commentary"

" vim-matchup
lua require "plugins.vim-matchup"

" markdown previewer
if !exists('g:vscode')
  lua require "plugins.markdown-previewer"
endif

" quick-scope
if !exists('g:vscode')
  lua require "plugins.quick-scope"
endif

" neoformat
lua require "plugins.neoformat"

" firenvim
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" vim-markdown
lua require "plugins.vim-markdown"

" treesitter
lua require "plugins.treesitter"

" lspinstall
lua require "plugins.lsp"

" colorizer
lua require "plugins.colorizer"

" auto completion
lua require "plugins.nvim-cmp"

" snippets
lua require "plugins.snippets"

" gitsigns
lua require "plugins.gitsigns"

" which-key
lua require "plugins.which-key"

" neoscroll
lua require "plugins.neoscroll"

" indent-blankline
lua require "plugins.indent-blankline"

" todo-comments
lua require "plugins.todo-comments"
