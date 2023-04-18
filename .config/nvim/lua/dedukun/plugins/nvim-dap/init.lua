local present, _ = pcall(require, "dap")
if not present then
	return
end

require("dedukun.plugins.nvim-dap.adapters")
require("dedukun.plugins.nvim-dap.configurations")
require("dedukun.plugins.nvim-dap.ui")

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "Error", linehl = "", numhl = "" })
