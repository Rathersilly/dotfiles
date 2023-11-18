-- this makes norg concealment work properly
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.norg" },
	command = "set conceallevel=3",
})

vim.cmd([[
	augroup norg_wrap
		autocmd!
		autocmd FileType norg setlocal wrap
		"autocmd FileType norg setlocal columns=80
		autocmd FileType norg setlocal linebreak
		augroup END
]])
