local present, dap = pcall(require, "dap")
if not present then
	return
end

dap.configurations.gdscript = {
	{
		name = "Launch scene",
		type = "godot",
		request = "launch",
		project = "${workspaceFolder}",
		launch_scene = true,
	},
}

-- dap.configurations.c = {
-- 	{
-- 		name = "g++ - Build and debug active file",
-- 		type = "lldb",
-- 		request = "launch",
-- 		program = "${fileDirname}/${fileBasenameNoExtension}",
-- 		stopAtEntry = false,
-- 		cwd = "${workspaceFolder}",
-- 		console = "externalTerminal",
-- 		MIMode = "gdb",
-- 		setupCommands = {
-- 			{
-- 				description = "Enable pretty-printing for gdb",
-- 				text = "-enable-pretty-printing",
-- 				ignoreFailures = true,
-- 			},
-- 		},
-- 		preLaunchTask = "C/C++: g++ build active file",
-- 		miDebuggerPath = "/usr/bin/gdb",
-- 	},
-- 	{
-- 		name = "nRF OpenOCD",
-- 		type = "lldb",
-- 		request = "launch",
-- 		program = "build-rxcontroller/firmware.elf",
-- 		stopAtEntry = false,
-- 		cwd = "${workspaceFolder}",
-- 		-- console = "externalTerminal",
-- 		MIMode = "gdb",
-- 		miDebuggerServerAddress = 'localhost:2331',
-- 		miDebuggerPath = "/usr/bin/arm-none-eabi-gdb",
-- 		setupCommands = {
-- 			{
-- 				text = "target remote localhost:2331",
-- 			},
-- 			{
-- 				text = "file build-rxcontroller/firmware.elf",
-- 			},
-- 			{
-- 				text = "monitor reset 0",
-- 			},
-- 			{
-- 				text = "load",
-- 			},
-- 		},
-- 	},
-- 	{
-- 		name = "ESP32 OpenOCD",
-- 		type = "lldb",
-- 		request = "launch",
-- 		cwd = "${workspaceFolder}/build",
-- 		program = "${workspaceRoot}/build/tamburi.elf",
-- 		miDebuggerPath = "xtensa-esp32-elf-gdb",
-- 		setupCommands = {
-- 			{
-- 				text = "target remote 127.0.0.1:3333",
-- 			},
-- 			{
-- 				text = "set remote hardware-watchpoint-limit 2",
-- 			},
-- 			{
-- 				text = "monitor reset ha1t",
-- 			},
-- 			{
-- 				text = "flushregs",
-- 			},
-- 			{
-- 				text = "mon program_esp build/bootloader.bin 0x1000 verify ",
-- 			},
-- 			{
-- 				text = "mon program_esp build/partition_table/partition-table.bin 0x8000 verify",
-- 			},
-- 			{
-- 				text = "mon program_esp build/tamburi.bin 0x10000 verify",
-- 			},
-- 			-- {
-- 			-- 	text = "mon program_esp build/ota_data_initial.bin 0xd000 verify",
-- 			-- },
-- 			{
-- 				text = "flushregs",
-- 			},
-- 		},
-- 	},
-- }
-- dap.configurations.cpp = dap.configurations.c
-- dap.configurations.rust = dap.configurations.c
