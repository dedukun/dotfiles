local M = {}

-- PRIVATE FUNCTIONS

local file_exists = function(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- PUBLIC FUNCTIONS

function M.generateTags()
	if file_exists("generate-tags.sh") then
		if os.execute("./generate-tags.sh") ~= 0 then
			print("Error generating tags")
		else
			print("Generated tags correctly")
		end
	elseif file_exists("../generate-tags.sh") then
		if os.execute("../generate-tags.sh") ~= 0 then
			print("Error generating tags")
		else
			print("Generated tags correctly")
		end
	else
		print("No tag generation script found!")
	end
end

function M.createHeader(comment)
	local input_data
	if comment == nil then
		input_data = vim.fn.input("Comment -> ")
	else
		input_data = comment
	end

	if string.len(input_data) == 0 then
		return
	end

	local header_size = 45
	local minimun_border_size = 6
	local border_character = "*"
	local inside_character = "="
	local final_comment_size = #input_data * 2 + 1

	if final_comment_size > (header_size - minimun_border_size) then
		header_size = final_comment_size + minimun_border_size

		print("Header Size was extended to ", header_size)
	end

	local lines = {}
	local print_str = "/*" .. string.rep(border_character, header_size) .. "*"
	table.insert(lines, print_str)

	local end_filler_counter = ((header_size - final_comment_size) / 2)
	print_str = " *" .. border_character .. string.rep(inside_character, (end_filler_counter - 1))
	for i = 1, #input_data do
		print_str = print_str .. " " .. string.upper(input_data:sub(i, i))
	end
	print_str = print_str .. " " .. string.rep(inside_character, (end_filler_counter - 1)) .. border_character .. "*"
	table.insert(lines, print_str)

	print_str = " *" .. string.rep(border_character, header_size) .. "*/"
	table.insert(lines, print_str)

	local linenr = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, linenr, linenr, false, lines)
end

return M
