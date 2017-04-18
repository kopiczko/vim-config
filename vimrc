" vim: fdm=marker

" Vim Settings {{{

if has('nvim')
  set termguicolors
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  set inccommand=nosplit " live substitution
endif

if !has('nvim')
  set nocompatible   " disable vi-compatibility
  set t_Co=256       " explicitly tell Vim that the terminal supports 256 colors

  set encoding=utf-8
  set fileencoding=utf-8
endif

syntax on
filetype plugin indent on

set noerrorbells             " No beeps
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set nosplitright             " Split vertical windows left bo the current windows
set splitbelow               " Split horizontal windows below to the current windows
set hidden

" statusline always visible
set laststatus=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <CR> :nohlsearch<CR>

" tabs
set tabstop=8
set shiftwidth=4
set expandtab
set shiftround

" handle long lines
set number
set wrap
set linebreak
set breakindent
let &showbreak = '↳ '
"let &showbreak = '↪ '
set textwidth=79
set formatoptions=qrn1
set cursorline
set colorcolumn=100
hi ColorColumn ctermbg=lightgrey

set matchtime=0

set modeline

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set clipboard=unnamed
  else
    set clipboard=unnamedplus
  endif
endif

autocmd FileType help wincmd H " open help vertically

set wildignore+=*/log/*,*/target/*,*.class     " MacOSX/Linux

let mapleader = ","
let maplocalleader = ","

inoremap jk <esc>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <C-a> ^
nnoremap <C-e> $
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A
nnoremap <M-=> <C-a>
nnoremap <M--> <C-x>
nnoremap <S-h> :bp<CR>
nnoremap <S-l> :bn<CR>
nnoremap j gj
nnoremap k gk

vnoremap " <esc><esc>`<i"<esc>`>la"<esc>

"onoremap in( :<c-u>normal! f(vi(<cr>
"onoremap il( :<c-u>normal! F)vi(<cr>

iabbrev @@ kopiczko@gmail.com
iabbrev retunr return
iabbrev reutnr return

execute pathogen#infect()
if has('mac')       " mac settigns
elseif has('unix')  " linux settings
  let g:netrw_browsex_viewer = 'xdg-open'
endif

" }}}

" python {{{
"
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
if has('nvim')
  let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
endif
" }}}

" color theme {{{
colorscheme PaperColor

set background=light
highlight Visual ctermbg=Grey
" }}}

" window navigation {{{
let g:tmux_navigator_no_mappings = 1
if !empty($TMUX)
  nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <Esc>\ :TmuxNavigatePrevious<cr>
else
  nnoremap <silent> <M-h> <C-w>h
  nnoremap <silent> <M-j> <C-w>j
  nnoremap <silent> <M-k> <C-w>k
  nnoremap <silent> <M-l> <C-w>l
endif
" }}}

" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ }
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }}}

" syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" tagbar {{{
nmap <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0
" }}}

" vim-go {{{
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_fmt_command = "goimports"

augroup vimgo
  autocmd!

  autocmd FileType go nmap <buffer> <leader>r <Plug>(go-run)
  autocmd FileType go nmap <buffer> <leader>d <Plug>(go-doc)
  autocmd FileType go nmap <buffer> <C-]> <Plug>(go-def)

  autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8

augroup END

" }}}

" tern_for_vim {{{

augroup ternforvim
  autocmd!

  autocmd FileType javascript nmap <buffer> <C-]> :TernDef<CR>

  autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" }}}

" rust {{{
let g:ftplugin_rust_source_path = $HOME.'/code/rust-lang/rust/src'
let g:rustfmt_autosave = 1

" vim-racer
let g:racer_cmd=$HOME.'/.cargo/bin/racer'
let g:racer_no_default_keymappings = 1

" tagbar settings for rust
let g:tagbar_type_rust = {
   \ 'ctagstype' : 'rust',
   \ 'kinds' : [
       \'T:types,type definitions',
       \'f:functions,function definitions',
       \'g:enum,enumeration names',
       \'s:structure names',
       \'m:modules,module names',
       \'c:consts,static constants',
       \'t:traits,traits',
       \'i:impls,trait implementations',
   \]
   \}

augroup rust
  autocmd!

  autocmd filetype rust nmap <buffer> <c-]> <Plug>RacerGoToDefinitionDrect
augroup END

" }}}

" markdown {{{
augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END
" }}}

noremap <F2> :NERDTreeFind<CR>
