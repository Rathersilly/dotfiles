"
"
" Hello! Welcome!
"
"

:set lines=150 columns=100
:colorscheme jellybeans

" inoremap = in insert mode, non-recursively map button(s) to other button(s)
inoremap jk <Esc>
inoremap kj <Esc>
inoremap jj <Esc>
inoremap fd <Esc>
inoremap df <Esc>
inoremap uu <Esc>

inoremap <Esc> <Esc>`^

:fixdel

" a legacy Software Flow Control thing
" XON/XOFF
" stty -ixon <--- this needs to be in ~/.bashrc

" makes vim incompatible with vi - makes insert mode arrow keys work as
" expected
set nocompatible 

" Insert line in normal mode, staying on current line in normal mode.

nmap <CR> o<Esc>
nmap <S-CR> O<Esc>

" make tab work as expected in normal mode
nmap <Tab> >>
nmap <S-Tab> <<

" ctrl tab switches tabs like chrome
" ONLY WORKS IN GVIM - actually gt/gT are even better
nmap <C-Tab> <C-PageDown>
nmap <C-S-Tab> <C-PageUp>

"from https://medium.com/@todariasova/rails-vim-101-essential-vim-plugins-for-ruby-on-rails-development-d74e808d186d
set number
filetype plugin indent on
filetype on
filetype indent on


" Ruby stuff: from janjiss.com's rails vimrc file 
" ================
syntax on                 " Enable syntax highlighting  
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes  
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml,markdown set ai sw=2 sts=2 et
augroup END  
" ================

" swap files in a common location
"
set dir=~/.vim/_swap//

" backup files (~) in a common location if possible
set backup
set backupdir=~/.vim/_backup/,~/tmp,.

" turn on undo files, put them in a common location
set undofile
set undodir=~/.vim/_undo/

" mouse works - scroll wheel, select visual mode, etc
set mouse=a

" avoid "press ENTER or type command to continue" prompt
set shortmess=a

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  autocmd!

  autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
  autocmd FileType ruby xmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)

  autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing-is-believing-mark)

  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-run)
augroup END
