local present, formatter = pcall(require, "formatter")
if not present then
	return
end

formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		arduino = {
			require("formatter.filetypes.c").clangformat,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		cmake = {
			require("formatter.filetypes.cmake").cmakeformat,
		},
		gdscript = {
			function()
				return {
					exe = "gdformat -",
					stdin = true,
				}
			end,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		htmldjango = {
			require("formatter.filetypes.html").prettier,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettier,
		},
		python = {
			require("formatter.filetypes.python").black,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
		toml = {
			require("formatter.filetypes.toml").taplo,
		},
		zig = {
			require("formatter.filetypes.zig").zigfmt,
		},

		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.keymap.set("n", "<leader>F", ":Format<CR>")
vim.keymap.set("n", "<space>ff", ":Format<CR>")
