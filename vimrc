syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8

set modeline

set clipboard=unnamedplus

execute pathogen#infect()

" CtrlP {{{
let g:ctrlp_working_path_mode = 'ra'
" }}}

augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

