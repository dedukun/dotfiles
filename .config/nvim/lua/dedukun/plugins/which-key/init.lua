local present, which = pcall(require, "which-key")
if not present then
	return
end

which.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})
