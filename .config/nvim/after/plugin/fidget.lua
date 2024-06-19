local present, fidget = pcall(require, "fidget")
if not present then
	return
end

fidget.setup({
	notification = {
		window = {
			winblend = 0, -- Background color opacity in the notification window
			-- y_padding = 1, -- Padding from bottom edge of window boundary
		},
	},
})

-- overwrite notification backend
vim.notify = require("fidget.notification").notify
