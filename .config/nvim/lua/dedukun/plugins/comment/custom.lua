local present, _ = pcall(require, "Comment")
if not present then
	return
end

local ft = require("Comment.ft")

ft.set("dosini", "# %s")
ft.set("gdscript", "# %s")
ft.set("gdscript3", "# %s")
ft.set("markdown", "<!-- %s -->")
ft.set("matlab", "% %s")
ft.set("mib", "-- %s")
ft.set("octave", "% %s")
ft.set("sxhkdrc", "# %s")
