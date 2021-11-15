----------------------
-- General Settings
----------------------

vim.opt.hidden = true
vim.opt.autoindent = true -- indent at the same level of the previous line
vim.opt.autoread = true -- automatically read a file changed outside of vim
vim.opt.termguicolors = true -- number of colors
vim.opt.tabstop = 4 -- tabs are 4 spaces
vim.opt.shiftwidth = 4 -- spaces used in auto indenting
vim.opt.expandtab = true -- replace tabs with spaces
vim.opt.mouse = "a" -- enable mouse
vim.opt.tw = 0 -- maximum width of text that is being inserted
vim.opt.cursorline = true -- set a line where the cursor is
vim.opt.showcmd = true -- show commands in the lower right corner
vim.opt.showmatch = true -- show matching brackets/parentthesis
vim.opt.number = true -- set number of the lines in the side
vim.opt.hlsearch = true -- highlight all search matches
vim.opt.ignorecase = true -- searches are case insensitive
vim.opt.smartcase = true -- search will be case sensitive if it contains an uppercase letter

vim.opt.splitbelow = true -- make splits open at the bottom
vim.opt.splitright = true -- make splits open at the right
vim.opt.bg = "dark"
-- use special register '*' or '+' for all
if vim.fn.has("unnamedplus") == 1 then
	-- yank, delete, ...
	vim.opt.clipboard = "unnamedplus"
else
	vim.opt.clipboard = "unnamed"
end
vim.opt.encoding = "UTF-8" -- add support for utf-8 encoding
vim.opt.undofile = false -- don't create .un~ file for persistent undo
vim.opt.backup = false --
vim.opt.writebackup = false
vim.opt.wildmode = { "longest", "list", "full" } -- do a partial complete first
vim.opt.wildmenu = true -- command-line completion in enhanced mode
vim.opt.spelllang = { "en", "pt" } -- languages for spell checker
vim.opt.complete = { ".", "w", "b", "u", "t", "i", "kspell" } -- complete options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.updatetime = 300
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages.
vim.opt.signcolumn = "yes" -- show the signcolumn
vim.o.lazyredraw = true -- useful for when executing macros.
vim.o.ttimeoutlen = 10 -- ms to wait for a key code seq to complete

-- Change the directory where temporary files are stored
vim.opt.backupdir = "/home/dedukun/.config/nvim/.backup//"
vim.opt.directory = "/home/dedukun/.config/nvim/.backup//"

-- Tags files default locations
vim.opt.tags = { "tags", "./tags" }

-- set color scheme
vim.g.gruvbox_flat_style = "dark"
vim.cmd([[colorscheme gruvbox-flat]])

-- python paths
vim.g.python_host_prog = "/home/dedukun/.virtualenvs/vim-python2/bin/python2"
vim.g.python3_host_prog = "/home/dedukun/.virtualenvs/vim/bin/python"
