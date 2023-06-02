local present, null_ls = pcall(require, "null-ls")
if not present then
	return
end

local presentMasonNull, mason_null_ls = pcall(require, "mason-null-ls")
if not presentMasonNull then
	return
end

-- THIS FIXES UPSTREAM PROBLEM
-- ISSUE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end

mason_null_ls.setup({
	automatic_setup = true,
	handlers = {
		function(source_name, methods)
			-- all sources with no handler get passed here
			-- Keep original functionality of `automatic_setup = true`
			require("mason-null-ls.automatic_setup")(source_name, methods)
		end,
		clang_format = function()
			null_ls.register(null_ls.builtins.formatting.clang_format.with({
				extra_filetypes = { "arduino" },
			}))
		end,
	},
})

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.eslint,
	},
})
