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
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			elseif neogen.jumpable() then
				vim.fn.feedkeys(t("<cmd>lua require('neogen').jump_next()<CR>"), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<A-S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			elseif neogen.jumpable(-1) then
				vim.fn.feedkeys(t("<cmd>lua require('neogen').jump_prev()<CR>"), "")
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
	-- enabled = function()
	-- 	return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	-- end,

	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
        { name = "crates" },
		-- { name = "dap" },
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
