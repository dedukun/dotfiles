local present, oil = pcall(require, "oil")
if not present then
	return
end

oil.setup({
	keymaps = {
		["<C-h>"] = false,
	},
	view_options = {
		show_hidden = true,
	},
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
-- vim.keymap.set("n", "<space>-", require("oil").toogle_float)
