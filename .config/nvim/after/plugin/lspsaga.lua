local present, lspsaga = pcall(require, "lspsaga")
if not present then
	return
end

lspsaga.setup({
	ui = {
		code_action = "",
	},
})
