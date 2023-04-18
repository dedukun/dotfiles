------------------------
-- Maps Configuration --
------------------------

local present, mapx = pcall(require, "mapx")
if not present then
	return
end

mapx.setup({ global = true, whichkey = true })

-- Vmap for maintain visual mode after shifting
vmap("<", "<gv")
vmap(">", ">gv")

-- Set map leader
vim.g.mapleader = ","

-- Remove all spaces at the end of lines
nnoremap("<leader>cc", ":StripWhitespace<CR>")

-- create section header
nnoremap("<leader>h", "<cmd>lua require'dedukun.tools'.createHeader()<CR>")

-- Build tags file
nnoremap("<leader>t", ":!ctags -R .<CR>")
nnoremap("<leader>T", "<cmd>lua require'dedukun.tools'.generateTags()<CR>")

-- clear highlights
nnoremap("<leader>n", ":noh<CR>")

-- toogle number
nnoremap("<leader>N", ":call ToggleNumber()<CR>")

-- File Explorer
nnoremap("<leader>m", ":NvimTreeToggle<CR>")

-- Remap split windows navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Remap go back to file
-- <C-~> didn't seem to work as a replacement for <C-^>)
nnoremap("gb", "<C-^>")

-- Remap ^W_w to zoomwin
nnoremap("<C-w>w", ":ZoomWinTabToggle<CR>")

-- Fuzzy find for files
nnoremap("<C-p>", "<cmd>lua require('telescope.builtin').find_files({follow=true})<cr>")

-- Fuzzy find for lines in files
nnoremap("<leader><C-p>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- Fuzzy find for files in the Neovim lua configurations
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files({cwd='$HOME/.config/nvim/lua/dedukun'})<cr>")

-- Make shift tab work in insert mode
inoremap("<S-Tab>", "<C-d>")

-- Format buffer
nnoremap("<leader>F", "<cmd>lua vim.lsp.buf.format({ bufnr = bufnr })<cr>")

--------------------
-- LSPsaga
-- show hover doc
nnoremap("<silent> K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
-- scroll down hover doc or scroll in definition preview
nnoremap("<silent> <C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
-- scroll up hover doc
nnoremap("<silent> <C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

-- documentation
nnoremap("<leader>gd", "<cmd>lua require('neogen').generate()<cr>")
nnoremap("<leader>gc", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>")
nnoremap("<leader>gf", "<cmd>lua require('neogen').generate({ type = 'func' })<cr>")
nnoremap("<leader>gt", "<cmd>lua require('neogen').generate({ type = 'type' })<cr>")

-- trouble
nnoremap("<leader>x", "<cmd>lua require('neogen').generate()<cr>")
nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")

-- pick window
nnoremap("<leader>w", "<cmd>lua require('nvim-window').pick()<cr>")

-- documentation
-- nnoremap("<leader>dcc", "<cmd>lua require'dap'.continue()<cr>")
-- nnoremap("<leader>dcC", "<cmd>lua require'dap'.close()<cr>")
-- nnoremap("<leader>dcp", "<cmd>lua require'dap'.pause()<cr>")
-- nnoremap("<leader>dct", "<cmd>lua require'dap'.terminate()<cr>")
-- nnoremap("<leader>dso", "<cmd>lua require'dap'.step_over()<cr>")
-- nnoremap("<leader>dsi", "<cmd>lua require'dap'.step_into()<cr>")
-- nnoremap("<leader>dsO", "<cmd>lua require'dap'.step_out()<cr>")
-- nnoremap("<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
-- nnoremap("<leader>dT", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
-- nnoremap("<leader>dl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
-- nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
-- nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
-- nnoremap("<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
-- nnoremap("<leader>de", "<cmd>lua require'dapui'.eval()<cr>")
-- vnoremap("<leader>de", "<cmd>lua require'dapui'.eval()<cr>")

-- barbar
-- Move to previous/next
nnoremap("<A-,>", ":BufferPrevious<CR>")
nnoremap("<A-.>", ":BufferNext<CR>")
-- Re-order to previous/next
nnoremap("<A-<>", ":BufferMovePrevious<CR>")
nnoremap("<A->>", ":BufferMoveNext<CR>")
-- Goto buffer in position...
nnoremap("<A-1>", ":BufferGoto 1<CR>")
nnoremap("<A-2>", ":BufferGoto 2<CR>")
nnoremap("<A-3>", ":BufferGoto 3<CR>")
nnoremap("<A-4>", ":BufferGoto 4<CR>")
nnoremap("<A-5>", ":BufferGoto 5<CR>")
nnoremap("<A-6>", ":BufferGoto 6<CR>")
nnoremap("<A-7>", ":BufferGoto 7<CR>")
nnoremap("<A-8>", ":BufferGoto 8<CR>")
nnoremap("<A-9>", ":BufferGoto 9<CR>")
nnoremap("<A-0>", ":BufferLast<CR>")
-- Close buffer
nnoremap("<A-c>", ":BufferClose<CR>")
-- Magic buffer-picking mode
nnoremap("<A-p>", ":BufferPick<CR>")
-- Sort automatically by...
nnoremap("<Space>bb", ":BufferOrderByBufferNumber<CR>")
nnoremap("<Space>bd", ":BufferOrderByDirectory<CR>")
nnoremap("<Space>bl", ":BufferOrderByLanguage<CR>")
nnoremap("<Space>bw", ":BufferOrderByWindowNumber<CR>")
