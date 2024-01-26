local present, comment = pcall(require, "Comment")
if not present then
	return
end

comment.setup({
	---Add a space b/w comment and the line
	---@type boolean
	padding = true,

	---Whether the cursor should stay at its position
	---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
	---@type boolean
	sticky = true,

	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	---@type string|function
	ignore = nil,

	---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
	---@type table
	mappings = {
		---operator-pending mapping
		---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
		basic = true,
		---extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = true,
		---extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extended = false,
	},

	---LHS of toggle mapping in NORMAL + VISUAL mode
	---@type table
	toggler = {
		---line-comment keymap
		line = "gcc",
		---block-comment keymap
		block = "gbc",
	},

	---LHS of operator-pending mapping in NORMAL + VISUAL mode
	---@type table
	opleader = {
		---line-comment keymap
		line = "gc",
		---block-comment keymap
		block = "gb",
	},

	---Pre-hook, called before commenting the line
	---@type function|nil
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

	---Post-hook, called after commenting is done
	---@type function|nil
	post_hook = nil,
})

local ft = require("Comment.ft")

ft.set("dosini", "# %s")
ft.set("gdscript", "# %s")
ft.set("gdscript3", "# %s")
ft.set("markdown", "<!-- %s -->")
ft.set("matlab", "% %s")
ft.set("mib", "-- %s")
ft.set("octave", "% %s")
ft.set("sxhkdrc", "# %s")
