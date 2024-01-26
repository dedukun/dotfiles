local present, dap = pcall(require, "dap")
if not present then
	return
end

-- dap.adapters.lldb = {
-- 	type = "executable",
-- 	command = "/usr/bin/lldb-vscode",
-- 	name = "lldb",
-- }

dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}
