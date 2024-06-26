local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local presentCmp, cmp = pcall(require, "cmp")
if not presentCmp then
	return
end

local presentLuasnip, luasnip = pcall(require, "luasnip")
if not presentLuasnip then
	return
end

local presentLspkind, lspkind = pcall(require, "lspkind")
if not presentLspkind then
	return
end

local presentNeogen, neogen = pcall(require, "neogen")
if not presentNeogen then
	return
end

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<A-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif neogen.jumpable() then
				neogen.jump_next()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<A-S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif neogen.jumpable(true) then
				neogen.jump_prev()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				path = "[Path]",
				buffer = "[Buffer]",
				luasnip = "[Snp]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
			},
		}),
	},

	-- nvim-cmp by defaults disables autocomplete for prompt buffers
	enabled = function()
		return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,

	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "crates" },
	}),
})

-- Use buffer source for `/` and '?'.
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- DAP
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})
