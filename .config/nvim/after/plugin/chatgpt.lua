local present, chatgpt = pcall(require, "chatgpt")
if not present then
	return
end

-- -- Set chatgpt's options
-- local home = vim.fn.expand("$HOME")
-- chatgpt.setup({
-- 	api_key_cmd = "gpg --decrypt " .. home .. "/.config/mbp/oagpt.txt.gpg",
--
-- })
