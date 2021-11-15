""""""""""""""""""""
" Plugins Settings

" vim-better-whitespace
lua require "dedukun.plugins.vim-better-whitespace"

" lualine
lua require "dedukun.plugins.lualine"

" nvim tree
if !exists('g:vscode')
  lua require "dedukun.plugins.nvim-tree"
endif

" vimtex
if !exists('g:vscode')
  lua require "dedukun.plugins.vimtex"
endif

" editorconfig
lua require "dedukun.plugins.editorconfig"

" comment
lua require "dedukun.plugins.comment"

" vim-matchup
lua require "dedukun.plugins.vim-matchup"

" markdown previewer
if !exists('g:vscode')
  lua require "dedukun.plugins.markdown-previewer"
endif

" quick-scope
if !exists('g:vscode')
  lua require "dedukun.plugins.quick-scope"
endif

" neoformat
lua require "dedukun.plugins.neoformat"

" firenvim
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" vim-markdown
lua require "dedukun.plugins.vim-markdown"

" treesitter
lua require "dedukun.plugins.treesitter"

" lspinstall
lua require "dedukun.plugins.lsp"

" colorizer
lua require "dedukun.plugins.colorizer"

" auto completion
lua require "dedukun.plugins.nvim-cmp"

" snippets
lua require "dedukun.plugins.snippets"

" gitsigns
lua require "dedukun.plugins.gitsigns"

" which-key
lua require "dedukun.plugins.which-key"

" neoscroll
lua require "dedukun.plugins.neoscroll"

" indent-blankline
lua require "dedukun.plugins.indent-blankline"

" todo-comments
lua require "dedukun.plugins.todo-comments"

" dial
lua require "dedukun.plugins.dial"

" spellsitter
lua require "dedukun.plugins.spellsitter"

" lspsaga
lua require "dedukun.plugins.lspsaga"
