" This is my old init.vim, but when porting a section
" to init.lua, I am deleting it here to keep track.
"
" contains bits from:
" junegunn, janjiss,
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc
" https://github.com/martin-svk/dot-files/blob/master/neovim/init.vim

"----vim-plug plugin manager stuff
call plug#begin('~/.config/nvim/plugged')
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'her/synicons.vim'
	Plug 'ryanoasis/vim-devicons'


	" Ruby support (plays nicely with tpope/rbenv-ctags)
	Plug 'vim-ruby/vim-ruby'
	" Rails support (:A, :R, :Rmigration, :Rextract)
	Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }

	Plug 'dense-analysis/ale'
		:command! AD ALEDisable
		:command! AE ALEEnable
		:command! AF ALEFix
		let g:ale_enabled=0

	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
	Plug 'sukima/xmledit'

	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
call plug#end()
"----


" navigate c++ file with 1tbs/stroustrup indent style
" actually could add an or for either style
" would like these to be one keypress but not conflict with tags
" ACTUALLY might have to fix this for the function { placement
" since i made this before reading the standard
nmap ]g /^\w.*{\s*$<cr>
nmap [g ?^\w.*{\s*$<cr>
nmap ]] /^\w.*{\s*$<cr>
nmap [[ ?^\w.*{\s*$<cr>

" ----------------------------------------------------------------------------
" From Junegunn:
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" ----------------------------------------------------------------------------
nnoremap <leader>n :NERDTreeToggle<cr>

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
  autocmd FileType ruby noremap <buffer> <Leader>sa :call SibAnnotateAll("%")<CR>;
  autocmd FileType ruby noremap <buffer> <Leader>sm :call SibAnnotateMarked("%")<CR>;
  autocmd FileType ruby noremap <buffer> <Leader>sc :call SibCleanAnnotations("%")<CR>;
  autocmd FileType ruby noremap <buffer> <Leader>ss :call SibToggleMark()<CR>;

  autocmd FileType ruby vmap <buffer> <Leader>sa :call SibAnnotateAll("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>sm :call SibAnnotateMarked("'<,'>")<CR>;
  autocmd FileType ruby vmap <buffer> <Leader>sc :call SibCleanAnnotations("'<,'>")<CR>;
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
