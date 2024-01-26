local present, telescope = pcall(require, "telescope")
if not present then
	return
end

local function is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")

	return vim.v.shell_error == 0
end

local function get_git_root()
	local dot_git_path = vim.fn.finddir(".git", ".;")
	return vim.fn.fnamemodify(dot_git_path, ":h")
end

function Find_files_from_project_git_root()
	local opts = {
		follow = true,
	}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").find_files(opts)
end

function Live_grep_from_project_git_root()
	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end

	require("telescope.builtin").live_grep(opts)
end

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("undo")

-- Fuzzy find for files
vim.keymap.set("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files({follow=true})<cr>")

-- Fuzzy find for files from the root of the git directory
vim.keymap.set("n", "<C-S-p>", "<cmd>lua Find_files_from_project_git_root()<cr>")

-- Fuzzy find for lines in files
vim.keymap.set("n", "<leader><C-p>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- Fuzzy find for lines in files from the root of the git directory
vim.keymap.set("n", "<leader><C-S-p>", "<cmd>lua Live_grep_from_project_git_root()<cr>")

-- Fuzzy find for files in the Neovim lua configurations
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({cwd='$HOME/.config/nvim/'})<cr>")

-- undo tree
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>")
