local present, tmux = pcall(require, "tmux")
if not present then
	return
end

tmux.setup({})
