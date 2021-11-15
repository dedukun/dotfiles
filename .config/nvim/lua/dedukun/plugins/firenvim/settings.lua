local present, _ = pcall(require, "firenvim")
if not present then
	return
end

vim.cmd([[let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }]])

