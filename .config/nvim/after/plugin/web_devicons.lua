local present, web_icons = pcall(require, "nvim-web-devicons")
if not present then
	return
end

web_icons.setup({
	default = true,
})
