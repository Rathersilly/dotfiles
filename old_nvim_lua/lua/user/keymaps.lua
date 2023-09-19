local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
term_opts = 4

local keymap = vim.api.nvim_set_keymap
-- use keymap, not set, so that i can grep them and see them in 1 place
-- local set = vim.keymap.set -- these 2 lines are same - keymap.set added in 0.7.0

--https://github.com/nanotee/nvim-lua-guide
-- allows you to put '<tab>' in a function without it taken literally
local function t(str) -- t as in 'termcodes'
	-- Adjust boolean arguments as needed (probably dont need to)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Make Y behave like other capitals
keymap("n", "Y", "y$", opts)

--Make leader y yank to clipboard - must have xclip installed and clipboard+=unnamed+ in options.lua
keymap("v", "<leader>y", "\"+y", opts)
-- would like to do the following but conflicts with change x to y
-- keymap("n", "<leader>yy", "\"+yy", opts)

----------------------------------------:was
-- -- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

----------------------------------------
-- Normal --

-- change forward/back to down/up behavior
keymap("n", "<C-f>", "<C-d>", opts)
keymap("n", "<C-b>", "<C-u>", opts)

-- S-j/k is now extraline/yesterline
-- TODO find new binds for this - conflicts with n J - join lines
--keymap("n", "<S-j>", "<C-e>", opts)
--keymap("n", "<S-k>", "<C-y>", opts)

----------------------------------------
---- Tab Things

keymap("n", "<S-h>", ":tabprev<cr>", opts)
keymap("n", "<S-l>", ":tabnext<cr>", opts)

-- <tab>3 goes to tab 3
for num = 1, 9 do
	keymap("n", "<leader>" .. num, ":" .. num .. "tabnext<cr>", opts)
end

----------------------------------------
---- Buffer things

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)

----------------------------------------
---- Window things

--tab is now for switching windows. S-tab switches to nvim-tree and back
function _G.shifttab()
	return vim.fn.winnr() == 1 and t '<C-w>p' or t '<C-w>t'
end

vim.keymap.set('n', '<tab>', '<C-w>', opts)
vim.keymap.set('n', '<tab><tab>', '<C-w>w', opts)
vim.keymap.set('n', '<s-tab>', 'v:lua.shifttab()', { expr = true, noremap = true, })

-- Jump list (to newer position) - necesary after remapping tab
keymap("n", "<C-p>", "<C-i>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)


----------------------------------------
-- Insert

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

----------------------------------------
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- doesnt overwrite clipboard when replacing word

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--TODO check out the better terminal navigation keys
--Telescope
--keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)
--keymap("n", "<leader>d", "<cmd>Telescope live_grep<cr>", opts)

----------------------------------------
--fzf things
--check old init.vim for more - also junegunn's init.vim
keymap("n", "<leader>C", ":Colors<cr>", opts)
keymap("n", "<leader>f", ":Files<cr>", opts)
keymap("n", "<leader>b", ":Buffers<cr>", opts)
-- keymap("n", "<leader>l", ":Lines<cr>", opts)
keymap("n", "<leader>`", ":Marks<cr>", opts)
keymap("n", "<leader>g", ":Rg<cr>", opts)
vim.api.nvim_exec(
	[[
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }
]],
true)

keymap("n", ":Wa", ":wa", opts)
keymap("n", ":WA", ":wa", opts)
keymap("n", ":Wq", ":wq", opts)
keymap("n", ":WQ", ":wq", opts)
keymap("n", ":WQa", ":wqa", opts)
keymap("n", ":WQA", ":wqa", opts)

----------------------------------------
-- Which-key
keymap("n", "<leader>w", ":WhichKey<cr>", opts)
-- other keybinds set in nvimtree.lus

----------------------------------------
-- Nvimtree
keymap("n", "<leader>n", ":NvimTreeToggle<cr>", opts)
-- other keybinds set in nvimtree.lus

----------------------------------------
-- Null ls
-- TODO - check out :h lsp - its very rich. also used by cmp.
-- can fix the cmp enter twice problem probs
-- formatting_sync() vs formatting() is so that it will finish before you save and quit
keymap("n", "<leader>z", "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", opts)
-- ALSO theres tons of lsp keybinds in lsp/handlers.lua

----------------------------------------
-- Misc changes - can be sorted

-- . repeat command is now ;
keymap("n", ".", ";", opts)
keymap("n", ";", ".", opts)

--clear search highlighting
keymap("n", "<Leader>/", ":set hls!<cr>", opts)

-- <C-e> is autopairs fastwrap, set in autopairs.lua

--run ruby program
--probably remap this to \m and depend on filetype - same cmd for make
keymap("n", "<Leader>r", ":w<cr>:!ruby %<cr>", opts)

--convert this to lua at some point
vim.api.nvim_exec(
	[[
packadd termdebug
let g:termdebug_wide=1
nnoremap <Leader>t  :Termdebug a.out<cr>A
" making and running c progs
nnoremap <Leader>m :w<cr>:!make<cr>
nnoremap <Leader>a :!./a.out <cr>

" put semicolon at end of line without moving cursor
nnoremap <Leader>; m'A;<ESC>`'
"remap exit terminal mode
tnoremap <Esc> <C-\><C-n>



" replace x with y unless following a (as in max or axis) or e (as in next)
" :h regex /perl-patterns for lookaround info
" TODO: make it not change xform to yform
nnoremap <Leader>y :s/[aAeE]\@<!x/y/g<cr>
nnoremap <Leader>x :s/[aAeE]\@<!y/x/g<cr>

"set up line numbers
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


" https://github.com/zenbro/dotfiles/blob/master/.nvimrc
" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}
nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
" there was a weird bug where mapping <C-j> was creating a mapping
" for <NL>, which was interfering with SiB <Enter> keymapping:
" <Enter> was pasting last inserted text after calling the function.
" BUT bug seems to have disappeared. So strange.
"nnoremap <silent> <C-k> :move-2<cr>
"nnoremap <silent> <C-j> :move+<cr>
"unmap <NL>
"nnoremap <silent> <C-h> <<
"nnoremap <silent> <C-l> >>


" mouse
silent! set ttymouse=xterm2
set mouse=a

]], true)

--TODO
--Seeing is believing, ALE, maybe more fzf
