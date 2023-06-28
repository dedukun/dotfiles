local present, trouble = pcall(require, "trouble")
if not present then
	return
end

trouble.setup({})

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")

