------------------------
-- Maps Configuration --
------------------------

-- Set map leader
vim.g.mapleader = " "

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
vim.keymap.set("n", "<leader>cc", "<cmd>lua require('whitespace-nvim').trim()<CR>")

-- create section header
vim.keymap.set("n", "<leader>ch", "<cmd>lua require'dedukun.tools'.createHeader()<CR>")

-- clear highlights
vim.keymap.set("n", "<leader>n", ":noh<CR>")

-- File Explorer
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

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

-- Make shift tab work in insert mode
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Term toggle
vim.keymap.set({ "n", "t" }, "<C-Bslash>", "<cmd>Lspsaga term_toggle<CR>")
