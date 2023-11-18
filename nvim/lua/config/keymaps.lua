-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--https://github.com/nanotee/nvim-lua-guide
-- allows you to put '<tab>' in a function without it taken literally
local function t(str) -- t as in 'termcodes'
  -- Adjust boolean arguments as needed (probably dont need to)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---- Window things

--tab is now for switching windows. S-tab switches to nvim-tree and back
--this prev_winid is needed to help nvim-tree open file in prev window

function _G.set_prev_winid()
  _G.prev_winid = vim.api.nvim_get_current_win()
end

_G.prev_winid = vim.api.nvim_get_current_win()
function _G.shifttab()
  _G.prev_winid = vim.api.nvim_get_current_win()
  --<C-W>p goes to preview window and back
  return vim.fn.winnr() == 1 and t("<C-w>p") or t("<C-w>t")
end

--vim.keymap.set('n', '<tab>', ":lua set_prev_winid() <cr> <C-w>", opts)
vim.keymap.set("n", "<tab>", "<C-w>", opts)
vim.keymap.set("n", "<tab><tab>", "<C-w>w", opts)
vim.keymap.set("n", "<s-tab>", "v:lua.shifttab()", { expr = true, noremap = true })
