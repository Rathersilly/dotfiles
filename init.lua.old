require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
--require "user.telescope"
--require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.impatient"


vim.api.nvim_exec(
[[
"https://stackoverflow.com/questions/16754463/adding-erb-wrap-to-surround-vim
fun! AutoCmd_ERB()
"do some other settings/mappings for your ERB, if you have
"......
"the customized surrounding :
let b:surround_{char2nr('=')} = "<%= \r %>"
let b:surround_{char2nr('-')} = "<% \r %>"
endf
autocmd FileType erb call AutoCmd_ERB()
let ASDF = "HELLO"

]], true)

