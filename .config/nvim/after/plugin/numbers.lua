local present, numbers = pcall(require, "numbers")
if not present then
	return
end

-- TODO NOT IN USE AT THE MOMENT

numbers.setup({
	excluded_filetypes = {
		-- "harpoon"
	},
	norelative_events = {
		"InsertEnter",
		"WinLeave",
		"FocusLost",
		-- "BufNewFile",
		-- "BufReadPost",
		-- Added
		"BufLeave",
		"CmdlineEnter",
	},
	relative_events = {
		-- "VimEnter",
		"InsertLeave",
		"WinEnter",
		"FocusGained",
		-- Added
		"BufEnter",
		"CmdlineLeave",
	},
})
