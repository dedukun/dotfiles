local present, _ = pcall(require, "dap")
if not present then
	return
end

require("dedukun.plugins.nvim-dap.adapters")
require("dedukun.plugins.nvim-dap.configurations")
require("dedukun.plugins.nvim-dap.ui")

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "Error", linehl = "", numhl = "" })

-- keymaps
vim.keymap.set("n", "<leader>dcc", "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>dcC", "<cmd>lua require'dap'.close()<cr>")
vim.keymap.set("n", "<leader>dcp", "<cmd>lua require'dap'.pause()<cr>")
vim.keymap.set("n", "<leader>dct", "<cmd>lua require'dap'.terminate()<cr>")
vim.keymap.set("n", "<leader>dso", "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<leader>dsi", "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<leader>dsO", "<cmd>lua require'dap'.step_out()<cr>")
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>dT", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>")
vim.keymap.set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>")
