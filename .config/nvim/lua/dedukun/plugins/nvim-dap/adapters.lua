local present, dap = pcall(require, "dap")
if not present then
	return
end

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}
