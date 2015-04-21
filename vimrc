set nocompatible   " disable vi-compatibility
set t_Co=256       " explicitly tell Vim that the terminal supports 256 colors

syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8

" statusline always visible
set laststatus=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <CR> :nohlsearch<CR>

" tabs
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

" handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
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

set wildignore+=*/log/*,*/target/*,*.class     " MacOSX/Linux

let mapleader = ","
let maplocalleader = ","

inoremap jk <esc>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <C-a> ^
nnoremap <C-e> $
nnoremap - <C-x>
nnoremap = <C-a>
nnoremap <C-e> $
nnoremap <S-h> :bp<CR>
nnoremap <S-l> :bn<CR>

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

" Solarized theme {{{
"set background=dark
colorscheme desert
" }}}

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
" }}}

" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ }
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }}}

augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

noremap <F2> :NERDTreeToggle<CR>
