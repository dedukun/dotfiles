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

local presentNeodev, neodev = pcall(require, "neodev")
if not presentNeodev then
	return
end

local presentSignature, lsp_signature = pcall(require, "lsp_signature")
if not presentSignature then
	return
end

local presentNavic, navic = pcall(require, "nvim-navic")
if not presentNavic then
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

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

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

neodev.setup({})

lsp_signature.setup({})

mason.setup({
	ui = {
		border = "rounded",
	},
})

mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
	-- The default handler
	function(server_name) -- default handler (optional)
		local config = make_config()
		require("lspconfig")[server_name].setup(config)
	end,

	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["gdscript"] = function()
	-- 	local config = make_config()
	-- 	config.cmd = { "nc", "localhost", "6005" }
	-- 	require("lspconfig")["gdscript"].setup(config)
	-- end,
	["clangd"] = function()
		local config = make_config()
		config.filetypes = { "c", "cpp", "arduino" }
		require("lspconfig")["clangd"].setup(config)
	end,
	["omnisharp"] = function()
		local config = make_config()
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
		require("lspconfig")["omnisharp"].setup(config)
	end,
})

-- icons for diagnostics in gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
