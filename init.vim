colorscheme jellybeans
"set lines=150 columns=100
set number
set tabstop=4
set shiftwidth=4
set foldcolumn=1
set encoding=UTF-8

" remap leader to space
:let mapleader = ";"
noremap . ;
noremap <Space> .
" clear search highlighting
nnoremap <Leader>/ :noh<cr>
" run ruby program
nnoremap <Leader>r :!ruby %<cr>
" put semicolon at end of line without moving cursor
nnoremap <Leader>; m'A;<ESC>`'

" tab is now for switching windows. S-tab switches to Nerdtree and back
" (my first ever vim function - im pretty stoked ngl)
nnoremap <tab> <C-W>
nnoremap <tab><tab> <C-W>w

nnoremap <silent> <S-tab> :call NerdOrPrev()<cr>
function! NerdOrPrev()
	if winnr() == 1
		exe "wincmd p"
	else
		exe "1wincmd w"
	endif
endfunction

:command AF ALEFix
:command AD ALEDisable
:command AE ALEEnable
"----vim-plug plugin manager stuff
call plug#begin('~/.config/nvim/plugged')
	Plug 'preservim/nerdtree'
	Plug 'dense-analysis/ale'
	Plug 'sukima/xmledit'
	Plug 'her/synicons.vim'
	Plug 'ryanoasis/vim-devicons'
call plug#end()
"----

" resize window CTRL+(h|j|k|l)
" nnoremap <C-J> <C-W>-
" nnoremap <C-K> <C-W>+
" nnoremap <C-L> <C-W>>
" nnoremap <C-H> <C-W><

" https://github.com/junegunn/dotfiles/blob/master/vimrc
noremap <C-F> <C-D>
noremap <C-B> <C-U>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
"nnoremap <tab>   <c-w>w
"nnoremap <S-tab> <c-w>W
"
" Jump list (to newer position) - necesary after remapping tab
nnoremap <C-p> <C-i>

" <leader>n | NERD Tree
nnoremap <leader>n :NERDTreeToggle<cr>

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>

" Make Y behave like other capitals
nnoremap Y y$

" mouse
silent! set ttymouse=xterm2
set mouse=a

"remap exit terminal mode
tnoremap <Esc> <C-\><C-n>

"windows split in a more harmonious way
set splitbelow
set splitright

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


" ===== Seeing Is Believing =====
" Assumes you have a Ruby with SiB available in the PATH
" If it doesn't work, you may need to `gem install seeing_is_believing`

" <Leader> is \ by default BTW

function! WithoutChangingCursor(fn)
  let cursor_pos     = getpos('.')
  let wintop_pos     = getpos('w0')
  let old_lazyredraw = &lazyredraw
  let old_scrolloff  = &scrolloff
  set lazyredraw

  call a:fn()

  call setpos('.', wintop_pos)
  call setpos('.', cursor_pos)
  redraw
  let &lazyredraw = old_lazyredraw
  let scrolloff   = old_scrolloff
endfun

function! SibAnnotateAll(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibAnnotateMarked(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --xmpfilter-style --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibCleanAnnotations(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --clean"]))
endfun

function! SibToggleMark()
  let pos  = getpos('.')
  let line = getline(".")
  if line =~ '^\s*$'
    let line = '# => '
  elseif line =~ '# =>'
    let line = substitute(line, ' *# =>.*', '', '')
  else
    let line .= '  # => '
  end
  call setline('.', line)
  call setpos('.', pos)
endfun

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  " clear the settings if they already exist (so we don't run them twice)
  autocmd!
  autocmd FileType ruby nmap <buffer> <Leader>z :call SibAnnotateAll("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Leader>x :call SibAnnotateMarked("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Leader>c :call SibCleanAnnotations("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Enter>   :call SibToggleMark()<CR>;
  autocmd FileType ruby vmap <buffer> <Enter>   :call SibToggleMark()<CR>;

  autocmd FileType ruby vmap <buffer> <Leader>b :call SibAnnotateAll("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>n :call SibAnnotateMarked("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>v :call SibCleanAnnotations("'<,'>")<CR>;
augroup END

"ALEFix
let g:ale_fixers = ['rubocop']

"""""""""The following is for generating ALE vim help files

" Put these lines at the very end of your vimrc file.
" " Load all plugins now.
" " Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" " Load all of the helptags now, after plugins have been loaded.
" " All messages and errors will be ignored.
silent! helptags ALL
