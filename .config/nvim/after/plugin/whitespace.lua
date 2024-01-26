local present, whitespace = pcall(require, "whitespace-nvim")
if not present then
	return
end

whitespace.setup({
	-- `highlight` configures which highlight is used to display
	-- trailing whitespace
	highlight = "DiffDelete",

	-- `ignored_filetypes` configures which filetypes to ignore when
	-- displaying trailing whitespace
	ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "mason", "lazy", "lspinfo", "checkhealth" },

	-- `ignore_terminal` configures whether to ignore terminal buffers
	ignore_terminal = true,
})
