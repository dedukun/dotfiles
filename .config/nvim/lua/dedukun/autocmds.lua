-------------------
-- Auto Commands --
-------------------

-- set .S syntax
vim.cmd([[autocmd BufNewFile,BufRead *.S set syntax=c | set ft=c]])

-- Disable automatic commenting on newline
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- Enable maximum text width and spell check for some files
vim.cmd([[autocmd FileType tex set tw=200 | set spell]])
vim.cmd([[autocmd FileType gitcommit set tw=100 | set spell]])
vim.cmd([[autocmd FileType markdown set tw=100 | set spell]])

-- Check for autoread
vim.cmd([[augroup checktime
    autocmd!
    if !has("gui_running")
        autocmd FocusGained     * silent! checktime
        autocmd BufEnter        * silent! checktime
    endif
augroup end]])

-- Delete bash 'edit-and-execute-command' (C-xC-e, or, if vi-mode enabled, <Esc>v) temporary file when opening it
--
-- Case: When using bash 'edit-and-execute-command', if you open the mode with nothing on the command-line,
-- and after writing something you quit without saving, the temporary script will not run, as the file doesn't
-- exists in the system. However, when starting this mode with something already in the command-line, the
-- temporary script file will be created an saved in the system automatically, so even if you leave the mode
-- without saving it, the command that was originally in the command-line will still run.
-- Fix: The autocmd's bellow deletes the temporary file when vim starts reading it to the buffer, so the script needs
-- to be saved before it is executed.
vim.cmd([[augroup del_bash_tmp_script
    autocmd FileChangedShell /tmp/bash-fc.* execute
    autocmd BufRead /tmp/bash-fc.* !rm %
augroup end]])

-- Sets foldmethod in the syntax file
vim.cmd([[autocmd Syntax c,cpp,vim,rust setlocal foldmethod=syntax foldlevel=99]])

-- highlight yanked selection
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 125 })
	end,
})
