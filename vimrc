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

" handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

set modeline

set clipboard=unnamedplus

set wildignore+=*/log/*,*/target/*,*.class     " MacOSX/Linux

execute pathogen#infect()

colorscheme jellybeans

if has('mac')       " mac settigns
elseif has('unix')  " linux settings
  let g:netrw_browsex_viewer = 'xdg-open'
endif

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
" }}}

" Powerline {{{
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" }}}

augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

