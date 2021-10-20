local present, nvim_comment = pcall(require, "nvim_comment")
if not present then
	return
end

local cmd = vim.api.nvim_command

local function set_commentstring(filetype, commentstring)
	cmd("augroup set-commentstring-" .. filetype)
	cmd("autocmd!")
	cmd(
		"autocmd BufEnter "
			.. filetype
			.. ':lua vim.api.nvim_buf_set_option(0, "commentstring", '
			.. commentstring
			.. '"// %s")'
	)
	cmd(
		"autocmd BufFilePost "
			.. filetype
			.. ':lua vim.api.nvim_buf_set_option(0, "commentstring", '
			.. commentstring
			.. '"// %s")'
	)
	cmd("augroup END")
end

nvim_comment.setup({
	-- Linters prefer comment and line to have a space in between markers
	marker_padding = true,
	-- should comment out empty or whitespace only lines
	comment_empty = true,
	-- Should key mappings be created
	create_mappings = true,
	-- Normal mode mapping left hand side
	line_mapping = "gcc",
	-- Visual/Operator mapping left hand side
	operator_mapping = "gc",
	-- Hook function to call before commenting takes place
	hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end,
})

set_commentstring("matlab", "% %s")
set_commentstring("octave", "% %s")
set_commentstring("dosini", "# %s")
set_commentstring("markdown", "<!-- %s -->")
set_commentstring("gdscript3", "# %s")
set_commentstring("GDScript", "# %s")
set_commentstring("sxhkdrc", "# %s")
set_commentstring("mib", "-- %s")
