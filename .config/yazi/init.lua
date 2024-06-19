function serialize(obj)
	local lua = ""
	local t = type(obj)
	if t == "number" then
		lua = lua .. obj
	elseif t == "boolean" then
		lua = lua .. tostring(obj)
	elseif t == "string" then
		lua = lua .. string.format("%q", obj)
	elseif t == "table" then
		lua = lua .. "{"
		for k, v in pairs(obj) do
			lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
		end
		local metatable = getmetatable(obj)
		if metatable ~= nil and type(metatable.__index) == "table" then
			for k, v in pairs(metatable.__index) do
				lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
			end
		end
		lua = lua .. "}"
	elseif t == "nil" then
		return "nil"
	else
		return "err"
	end
	return lua
end

require("starship"):setup()
require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true })
require("bookmarks"):setup({
	persist = "vim",
	save_last_directory = true,
	desc_format = "full",
	notify = { enable = true },
})
