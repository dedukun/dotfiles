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

mason_null_ls.setup()

mason_null_ls.setup_handlers({
	function(source_name)
		-- all sources with no handler get passed here
	end,
	-- C
	cpplint = function()
		null_ls.register(null_ls.builtins.diagnostics.cpplint)
	end,
	clang_format = function()
		null_ls.register(null_ls.builtins.formatting.clang_format)
	end,
	-- Python
	flake8 = function()
		null_ls.register(null_ls.builtins.diagnostics.flake8)
	end,
	black = function()
		null_ls.register(null_ls.builtins.formatting.black)
	end,
	-- Shell
	shellcheck = function()
		null_ls.register(null_ls.builtins.diagnostics.shellcheck)
	end,
	shfmt = function()
		null_ls.register(null_ls.builtins.formatting.shfmt)
	end,
	-- Markdown
	markdownlint = function()
		null_ls.register(null_ls.builtins.diagnostics.markdownlint)
	end,
	-- Text
	proselint = function()
		null_ls.register(null_ls.builtins.diagnostics.proselint)
	end,
	-- JSON
	prettier = function()
		null_ls.register(null_ls.builtins.formatting.prettier)
	end,
	-- Lua
	selene = function()
		null_ls.register(null_ls.builtins.diagnostics.selene)
	end,
	stylua = function()
		null_ls.register(null_ls.builtins.formatting.stylua)
	end,
	-- SQL
	sqlfluff = function()
		null_ls.register(null_ls.builtins.diagnostics.sqlfluff)
	end,
	sql_formatter = function()
		null_ls.register(null_ls.builtins.formatting.sql_formatter)
	end,
	-- Docker
	hadolint = function()
		null_ls.register(null_ls.builtins.diagnostics.hadolint)
	end,
	-- Git
	gitlint = function()
		null_ls.register(null_ls.builtins.diagnostics.gitlint)
	end,
	-- Vim
	vint = function()
		null_ls.register(null_ls.builtins.diagnostics.vint)
	end,
	-- YAML
	yamllint = function()
		null_ls.register(null_ls.builtins.diagnostics.yamllint)
	end,
	yamlfmt = function()
		null_ls.register(null_ls.builtins.formatting.yamlfmt)
	end,
})

null_ls.setup({})
