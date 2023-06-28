------------------------
-- Maps Configuration --
------------------------

-- Set map leader
vim.g.mapleader = ","

-- make > and < stay with the selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- paste selection without losing previous copied value
vim.keymap.set("x", "<leader>p", '"_dP')

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

-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
