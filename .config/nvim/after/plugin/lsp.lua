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

local presentSignature, signature = pcall(require, "lsp_signature")
if not presentSignature then
	return
end

local presentNavic, navic = pcall(require, "nvim-navic")
if not presentNavic then
	return
end

-- keymaps
local on_attach = function(client, bufnr)
	-- local function buf_set_option(...)
	-- 	vim.api.nvim_buf_set_option(bufnr, ...)
	-- end
	--
	-- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", "<space>gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<space>gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<space>gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<CR>", opts)
	vim.keymap.set("n", "<space>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "<space>w", "<cmd>Lspsaga show_workspace_diagnostics ++normal<CR>", opts)
	vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, opts)

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	signature.on_attach({
		hint_enable = false,
	}, bufnr)
end

-- config that activates keymaps and enables snippet support
local function make_config()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
		inlay_hints = {
			enabled = false,
		},
	}
end

local function manual_servers()
	local config = make_config()
	lspconfig.gdscript.setup(config)
end

navic.setup({ highlight = true })

neodev.setup({})

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
		lspconfig[server_name].setup(config)
	end,

	["clangd"] = function()
		local config = make_config()
		config.filetypes = { "c", "cpp", "arduino" }
		lspconfig.clangd.setup(config)
	end,
	["zls"] = function()
		local config = make_config()
		lspconfig.zls.setup(config)

		-- zsl auto forces fmt on save, this disables it
		vim.g.zig_fmt_autosave = 0
	end,
	["lua_ls"] = function()
		local config = make_config()
		config.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
		lspconfig.lua_ls.setup(config)
	end,
})

manual_servers()

-- icons for diagnostics in gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
