local present, lint = pcall(require, "lint")
if not present then
	return
end

local ls = {}

-- lint.linters_by_ft = {
-- 	python = { "ruff" },
-- 	javascript = { "eslint_d" },
-- 	typescript = { "eslint_d" },
-- 	lua = { "selene" },
-- }
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     lint.try_lint()
--   end,
-- })
