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

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = {
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<A-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
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
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

			vim_item.menu = ({
				path = "[Path]",
				luasnip = "[Snp]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
			})[entry.source.name]

			return vim_item
		end,
	},

	experimental = {
		native_menu = true,
		ghost_text = true,
	},

	sources = {
		{ name = "path" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	},
})
