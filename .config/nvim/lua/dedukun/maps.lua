------------------------
-- Maps Configuration --
------------------------

-- Set map leader
vim.g.mapleader = ","

-- make > and < stay with the selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- paste selection without losing previous copied value
vim.keymap.set("x", "<leader>p", "\"_dP")

-- allow to move selected code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- make sure that cursor is in the middle when doing page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remove all spaces at the end of lines
vim.keymap.set("n", "<leader>cc", ":StripWhitespace<CR>")

-- create section header
vim.keymap.set("n", "<leader>h", "<cmd>lua require'dedukun.tools'.createHeader()<CR>")

-- Build tags file
vim.keymap.set("n", "<leader>t", ":!ctags -R .<CR>")
vim.keymap.set("n", "<leader>T", "<cmd>lua require'dedukun.tools'.generateTags()<CR>")

-- clear highlights
vim.keymap.set("n", "<leader>n", ":noh<CR>")

-- toogle number
vim.keymap.set("n", "<leader>N", ":call ToggleNumber()<CR>")

-- File Explorer
vim.keymap.set("n", "<leader>m", ":NvimTreeToggle<CR>")

-- Remap split windows navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Remap go back to file
-- <C-~> didn't seem to work as a replacement for <C-^>)
vim.keymap.set("n", "gb", "<C-^>")

-- Remap ^W_w to zoomwin
vim.keymap.set("n", "<C-w>w", ":ZoomWinTabToggle<CR>")

-- Fuzzy find for files
vim.keymap.set("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files({follow=true})<cr>")

-- Fuzzy find for lines in files
vim.keymap.set("n", "<leader><C-p>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- Fuzzy find for files in the Neovim lua configurations
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({cwd='$HOME/.config/nvim/'})<cr>")

-- Make shift tab work in insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Format buffer
vim.keymap.set("n", "<leader>F", "<cmd>lua vim.lsp.buf.format({ bufnr = bufnr })<cr>")

--------------------
-- LSPsaga
-- show hover doc
vim.keymap.set("n", "<silent> K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<silent> <C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
vim.keymap.set("n", "<silent> <C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
vim.keymap.set("n", "<leader>sca", "<cmd>Lspsaga code_action<CR>")

-- documentation
vim.keymap.set("n", "<leader>gd", "<cmd>lua require('neogen').generate()<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>")
vim.keymap.set("n", "<leader>gf", "<cmd>lua require('neogen').generate({ type = 'func' })<cr>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua require('neogen').generate({ type = 'type' })<cr>")

-- trouble
vim.keymap.set("n", "<leader>x", "<cmd>lua require('neogen').generate()<cr>")
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")

-- pick window
vim.keymap.set("n", "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>")

-- documentation
-- vim.keymap.set("n", "<leader>dcc", "<cmd>lua require'dap'.continue()<cr>")
-- vim.keymap.set("n", "<leader>dcC", "<cmd>lua require'dap'.close()<cr>")
-- vim.keymap.set("n", "<leader>dcp", "<cmd>lua require'dap'.pause()<cr>")
-- vim.keymap.set("n", "<leader>dct", "<cmd>lua require'dap'.terminate()<cr>")
-- vim.keymap.set("n", "<leader>dso", "<cmd>lua require'dap'.step_over()<cr>")
-- vim.keymap.set("n", "<leader>dsi", "<cmd>lua require'dap'.step_into()<cr>")
-- vim.keymap.set("n", "<leader>dsO", "<cmd>lua require'dap'.step_out()<cr>")
-- vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- vim.keymap.set("n", "<leader>dT", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
-- vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
-- vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>")
-- vim.keymap.set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>")

-- barbar
-- Move to previous/next
vim.keymap.set("n", "<A-,>", ":BufferPrevious<CR>")
vim.keymap.set("n", "<A-.>", ":BufferNext<CR>")
-- Re-order to previous/next
vim.keymap.set("n", "<A-<>", ":BufferMovePrevious<CR>")
vim.keymap.set("n", "<A->>", ":BufferMoveNext<CR>")
-- Goto buffer in position...
vim.keymap.set("n", "<A-1>", ":BufferGoto 1<CR>")
vim.keymap.set("n", "<A-2>", ":BufferGoto 2<CR>")
vim.keymap.set("n", "<A-3>", ":BufferGoto 3<CR>")
vim.keymap.set("n", "<A-4>", ":BufferGoto 4<CR>")
vim.keymap.set("n", "<A-5>", ":BufferGoto 5<CR>")
vim.keymap.set("n", "<A-6>", ":BufferGoto 6<CR>")
vim.keymap.set("n", "<A-7>", ":BufferGoto 7<CR>")
vim.keymap.set("n", "<A-8>", ":BufferGoto 8<CR>")
vim.keymap.set("n", "<A-9>", ":BufferGoto 9<CR>")
vim.keymap.set("n", "<A-0>", ":BufferLast<CR>")
-- Close buffer
vim.keymap.set("n", "<A-c>", ":BufferClose<CR>")
-- Magic buffer-picking mode
vim.keymap.set("n", "<A-p>", ":BufferPick<CR>")
-- Sort automatically by...
vim.keymap.set("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>")
vim.keymap.set("n", "<Space>bd", ":BufferOrderByDirectory<CR>")
vim.keymap.set("n", "<Space>bl", ":BufferOrderByLanguage<CR>")
vim.keymap.set("n", "<Space>bw", ":BufferOrderByWindowNumber<CR>")
-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
