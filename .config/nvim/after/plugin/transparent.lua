local present, transparent = pcall(require, "transparent")
if not present then
	return
end

transparent.setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    -- "BufferLineTabClose",
    -- "BufferlineBufferSelected",
    -- "BufferLineFill",
    -- "BufferLineBackground",
    -- "BufferLineSeparator",
    -- "BufferLineIndicatorSelected",
    "all"
  },
  -- exclude = {}, -- table: groups you don't want to clear
})
