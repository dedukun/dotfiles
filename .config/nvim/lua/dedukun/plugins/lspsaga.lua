local present, lspsaga = pcall(require, "lspsaga")
if not present then
	return
end

lspsaga.setup({
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	scroll_preview = {
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	ui = {
		code_action = "",
		kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
	},
})
