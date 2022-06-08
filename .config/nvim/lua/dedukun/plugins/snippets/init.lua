local present, luasnip = pcall(require, "luasnip")
if not present then
	return
end

luasnip.snippets = {
	c = {
		luasnip.parser.parse_snippet(
			{ trig = "#ifndefdef", wordTrig = true },
			"#ifndef ${1:DEBUG}\n#define $1\n\n$0\n\n#endif  /* $1 */"
		),
	},
	cpp = {
		luasnip.parser.parse_snippet(
			{ trig = "#ifndefdef", wordTrig = true },
			"#ifndef ${1:DEBUG}\n#define $1\n\n$0\n\n#endif  /* $1 */"
		),
	},
}

require("luasnip.loaders.from_vscode").load()
