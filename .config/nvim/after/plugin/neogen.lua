local present, neogen = pcall(require, "neogen")
if not present then
	return
end

neogen.setup({
	enabled = true,
	snippet_engine = "luasnip",
})

-- Keymaps
vim.keymap.set("n", "<leader>ggd", "<cmd>lua require('neogen').generate()<cr>")
vim.keymap.set("n", "<leader>ggc", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>")
vim.keymap.set("n", "<leader>ggf", "<cmd>lua require('neogen').generate({ type = 'func' })<cr>")
vim.keymap.set("n", "<leader>ggt", "<cmd>lua require('neogen').generate({ type = 'type' })<cr>")
