local present, neogen = pcall(require, "neogen")
if not present then
	return
end

neogen.setup({
	enabled = true,
})

-- Keymaps
vim.keymap.set("n", "<leader>gd", "<cmd>lua require('neogen').generate()<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>")
vim.keymap.set("n", "<leader>gf", "<cmd>lua require('neogen').generate({ type = 'func' })<cr>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua require('neogen').generate({ type = 'type' })<cr>")
