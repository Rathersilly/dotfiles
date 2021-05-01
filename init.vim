" Welcome! Judge not, its WIP

" contains bits from:
" junegunn, janjiss,
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc
" https://github.com/martin-svk/dot-files/blob/master/neovim/init.vim

colorscheme jellybeans
set tabstop=4
set shiftwidth=4
set foldcolumn=1
set encoding=UTF-8
"set timeoutlen=500				
set guicursor=					" cursor is block, even in ins mode
set hidden 						" can navigate away from unsaved file
set nowrap
set nohlsearch
set scrolloff=4


" remap leader to space
nnoremap <Space> <Nop>
:let mapleader=" "

"----vim-plug plugin manager stuff
call plug#begin('~/.config/nvim/plugged')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	" Ruby support (plays nicely with tpope/rbenv-ctags)
	Plug 'vim-ruby/vim-ruby'
	" Rails support (:A, :R, :Rmigration, :Rextract)
	Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }

	Plug 'danchoi/ri.vim'
		let g:ri_no_mappings=1
		nnoremap <Leader>i :call ri#OpenSearchPrompt(1)<cr>
		nnoremap <Leader>u :call ri#LookupNameUnderCursor()<cr>
	Plug 'preservim/nerdtree'
	Plug 'dense-analysis/ale'
		:command! AD ALEDisable
		:command! AE ALEEnable
		:command! AF ALEFix
		let g:ale_enabled=0
	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
	Plug 'sukima/xmledit'
	Plug 'tpope/vim-surround'

	Plug 'her/synicons.vim'
	Plug 'ryanoasis/vim-devicons'
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

noremap . ;
noremap ; .
" clear search highlighting
nnoremap <Leader>/ :set hls!<cr>

" run ruby program
" probably remap this to \m and depend on filetype - same cmd for make
nnoremap <Leader>r :w<cr>:!ruby %<cr>

packadd termdebug
let g:termdebug_wide=1
nnoremap <Leader>t  :Termdebug a.out<cr>A
" making and running c progs
nnoremap <Leader>m :w<cr>:!make <cr>
nnoremap <Leader>a :!./a.out <cr>

" put semicolon at end of line without moving cursor
nnoremap <Leader>; m'A;<ESC>`'
"remap exit terminal mode
tnoremap <Esc> <C-\><C-n>

" tab is now for switching windows. S-tab switches to Nerdtree and back
nnoremap <tab> <C-W>
nnoremap <tab><tab> <C-W>w
nnoremap <expr> <s-tab> winnr() == 1 ? "\<c-w>p" : "\<c-w>t>"

" Jump list (to newer position) - necesary after remapping tab
nnoremap <C-p> <C-i>

" replace x with y unless following a (as in max or axis) or e (as in next)
" :h regex /perl-patterns for lookaround info
nnoremap <Leader>y :s/[aAeE]\@<!x/y/g<cr>
nnoremap <Leader>x :s/[aAeE]\@<!y/x/g<cr>

"set up line numbers
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"windows split in a more harmonious way
set splitbelow
set splitright

" ----------------------------------------------------------------------------
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc
" Switch between tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
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


" ----------------------------------------------------------------------------
" From Junegunn:
" https://github.com/junegunn/dotfiles/blob/master/vimrc
" ----------------------------------------------------------------------------
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

" <leader>n | NERD Tree
nnoremap <leader>n :NERDTreeToggle<cr>

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
" there was a weird bug where mapping <C-j> was creating a mapping
" for <NL>, which was interfering with SiB <Enter> keymapping:
" <Enter> was pasting last inserted text after calling the function.
" BUT bug seems to have disappeared. So strange.
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
"unmap <NL>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>

" Make Y behave like other capitals
nnoremap Y y$

" mouse
silent! set ttymouse=xterm2
set mouse=a
" }}}
" ============================================================================
" FZF {{{
" ============================================================================

let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
" command! -nargs=? -complete=dir AF
"   \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
"   \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
"   \ })))

" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader>b        :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
"nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
"nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
"xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>g        :Rg<CR>

" I'm gonna remap the fzf open file hotkeys to nerdtree hotkeys for simplicity
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }

" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 499 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)

" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" ============================================================================
" end of junegunn's stuff }}}
" ============================================================================

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
  autocmd FileType ruby noremap <buffer> <Enter>    :call SibToggleMark()<CR>;

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
