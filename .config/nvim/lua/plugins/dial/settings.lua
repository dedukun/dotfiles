local present, _ = pcall(require, "dial")
if not present then
	return
end

vim.api.nvim_set_keymap("n", "<C-a>", "<Plug>(dial-increment)", {})
vim.api.nvim_set_keymap("n", "<C-x>", "<Plug>(dial-decrement)", {})
vim.api.nvim_set_keymap("v", "<C-a>", "<Plug>(dial-increment)", {})
vim.api.nvim_set_keymap("v", "<C-x>", "<Plug>(dial-decrement)", {})
vim.api.nvim_set_keymap("v", "g<C-a>", "<Plug>(dial-increment-additional)", {})
vim.api.nvim_set_keymap("v", "g<C-x>", "<Plug>(dial-decrement-additional)", {})
