local presentLspconfig, lspconfig = pcall(require, "lspconfig")
if not presentLspconfig then
	return
end

local presentMason, mason = pcall(require, "mason")
if not presentMason then
	return
end

local presentMasonLSP, mason_lspconfig = pcall(require, "mason-lspconfig")
if not presentMasonLSP then
	return
end

-- keymaps
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>r", "<cmd>Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "<space>a", "<cmd>Lspsaga code_action<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	-- buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", opts)
	-- buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end

	-- signature
	local present, lsp_signature = pcall(require, "lsp_signature")
	if not present then
		return
	end

	lsp_signature.on_attach({
		floating_window_above_cur_line = true,
		hint_enable = true,
		zindex = 50,
	})
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = "LuaJIT",
			path = vim.split(package.path, ";"),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
	},
}

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- adding folding capabilities
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
end

local function setup_manual_servers()
	local servers = {
		"gdscript",
		"omnisharp",
		-- modify default settings installed by lsp-installer
		"sumneko_lua",
		"clangd",
	}

	for _, lsp in pairs(servers) do
		local config = make_config()

		if lsp == "gdscript" then
			config.cmd = { "nc", "localhost", "6005" }
		elseif lsp == "sumneko_lua" then
			config.settings = lua_settings
		elseif lsp == "clangd" then
			config.filetypes = { "c", "cpp" }
		elseif lsp == "omnisharp" then
			local pid = vim.fn.getpid()
			local omnisharp_bin = "/home/dedukun/Applications/OmniSharp_V1.39.0/omnisharp/OmniSharp.exe"

			config.cmd = { "mono", omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) }
			config.filetypes = { "cs", "vb" }
			config.init_options = {}
			config.on_new_config = function(new_config, new_root_dir)
				if new_root_dir then
					table.insert(new_config.cmd, "-s")
					table.insert(new_config.cmd, new_root_dir)
				end
			end
			config.root_dir = lspconfig.util.root_pattern("*.sln")
		end

		lspconfig[lsp].setup(config)
	end
end

mason.setup({
	ui = {
		border = "rounded",
	},
})

mason_lspconfig.setup()

setup_manual_servers()

-- icons for diagnostics in gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
