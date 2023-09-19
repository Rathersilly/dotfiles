
-- this makes norg concealment work properly
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.norg"},
  command = "set conceallevel=3"
})

vim.cmd([[
	augroup norg_wrap
		autocmd!
		autocmd FileType norg setlocal wrap
		"autocmd FileType norg setlocal columns=80
		autocmd FileType norg setlocal linebreak
		augroup END
]])

require "bonj.options"
require "bonj.keymaps"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

opts = {}
require("lazy").setup("bonj/plugins", opts)


require "bonj.telescope"
require "bonj.comment"
require "bonj.nvim-tree"
require "bonj.treesitter"
require "bonj.lualine"
require "bonj.lsp"
