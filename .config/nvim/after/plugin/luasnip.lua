local present, luasnip = pcall(require, "luasnip")
if not present then
	return
end

luasnip.add_snippets("c", {
	luasnip.parser.parse_snippet(
		{ trig = "#ifndefdef", wordTrig = true },
		"#ifndef ${1:DEBUG}\n#define $1\n$0\n#endif  /* $1 */"
	),
})

luasnip.add_snippets("cpp", {
	luasnip.parser.parse_snippet(
		{ trig = "#ifndefdef", wordTrig = true },
		"#ifndef ${1:DEBUG}\n#define $1\n$0\n#endif  /* $1 */"
	),
})

require("luasnip.loaders.from_vscode").lazy_load()
