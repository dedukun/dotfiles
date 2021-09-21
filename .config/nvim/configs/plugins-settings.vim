""""""""""""""""""""
" Plugins Settings

" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist=['help', 'diff']
let g:better_whitespace_ctermcolor='DarkRed'

" lualine
lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-flat',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {'netrw'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',  { 'diff',
                              color_added ='#859D63',
                              color_modified = '#CB8237',
                              color_removed = '#C35C56',
                            }},
    lualine_c = {'filename', { 'diagnostics',
                               sources = {'nvim_lsp'},
                               symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
                             }},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF

" netrw
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 22
let g:netrw_list_hide = &wildignore

" nvim tree
let g:nvim_tree_ignore = [ '.git' ]
let g:nvim_tree_gitignore = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
highlight NvimTreeFolderIcon guibg=blue " a list of groups can be found at `:help nvim_tree_highlight`

" vimtex
if !exists('g:vscode')
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_view_method = 'zathura'
  let g:tex_flavor = 'latex'
endif

" editorconfig
let g:EditorConfig_exclude_patterns = ['scp://.\*', 'suda://.\*', 'term://.\*']

" vim-commentary
autocmd FileType matlab setlocal commentstring=\%\ %s
autocmd FileType octave setlocal commentstring=\%\ %s
autocmd FileType dosini setlocal commentstring=#\ %s
autocmd FileType markdown setlocal commentstring=<!--%s-->
autocmd FileType gdscript3 setlocal commentstring=#\ %s
autocmd FileType GDScript setlocal commentstring=#\ %s
autocmd FileType sxhkdrc setlocal commentstring=#\ %s
autocmd FileType mib setlocal commentstring=--\ %s

" vim-matchup
let g:matchup_matchparen_offscreen = {'method': 'popup'}

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

" neoformat
let g:shfmt_opt="-ci"

" firenvim
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  context_commentstring = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {'#CD6600', '#CD950C', '#CDBE70'}, -- table of hex strings
  },
  matchup = {
    enable = true,
  }
}
EOF

" colorizer
lua require'colorizer'.setup()

" lspinstall
lua <<EOF
-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  -- signature
  require'lsp_signature'.on_attach({
    floating_window_above_cur_line=true,
    hint_enable = false,
    zindex = 50
  })
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "clangd")
  table.insert(servers, "dartls")

  for _, server in pairs(servers) do

    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "clangd" then
      config.cmd = { "/home/dedukun/.scripts/clangd.sh", "--background-index", "--malloc-trim"}
      config.filetypes = {"c", "cpp"};
    end
    if server == "rust-analizer" then
      config.filetypes = {"rust"};
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
setup_servers() -- reload installed servers
vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- icons for diagnostics in gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
EOF

" auto completiotn
lua << EOF
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local luasnip = require("luasnip")
local lspkind = require('lspkind')
local cmp = require("cmp")
cmp.setup {
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },

    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-n>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-p>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<A-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<A-S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },

    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
        return vim_item
      end
    },

    sources = {
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' }
    },
  }
EOF

" snippets
lua <<EOF
local ls = require("luasnip")
ls.snippets = {
  c = {
    ls.parser.parse_snippet({trig = "#ifndefdef", wordTrig = true}, "#ifndef ${1:DEBUG}\n#define $1\n$0\n#endif  /* $1 */"),
  },
  cpp = {
    ls.parser.parse_snippet({trig = "#ifndefdef", wordTrig = true}, "#ifndef ${1:DEBUG}\n#define $1\n$0\n#endif  /* $1 */"),
  }
}
require("luasnip.loaders.from_vscode").load()
EOF

" gitsigns
lua << EOF
  require("gitsigns").setup {
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  }
EOF

" which-key
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" neoscroll
lua << EOF
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = "sine" ,
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
})
EOF

" indent_blankline
lua << EOF
require("indent_blankline").setup {
    char = "│",
    buftype_exclude = {"terminal"}
}
EOF

" todo-comments
lua << EOF
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
