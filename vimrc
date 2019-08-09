" vim: fdm=marker

" Vim Settings {{{

if has('nvim')
  set termguicolors

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

set hidden
set nobackup                 " Don't create annoying backup files
set noerrorbells             " No beeps
set nojoinspaces             " No double space after a dot
set nosplitright             " Split vertical windows left bo the current windows
set noswapfile               " Don't use swapfile
set splitbelow               " Split horizontal windows below to the current windows

" statusline always visible
set laststatus=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <CR> :nohlsearch<CR>           " Map enter to disable search highlight.

" Spell.
set spellcapcheck=       " Allow sentences starting with lower letter
set spelllang=en,custom
set spell

function! MyMkspell()
    :echo '---> creating en.utf-8.add.spl'
    :mkspell! ~/.vim/spell/en.utf-8.add.spl ~/.vim/spell/en.utf-8.add
    :echo '---> creating custom.utf-8.spl'
    :mkspell! ~/.vim/spell/custom.utf-8.spl ~/.vim/spell/custom.utf-8
endfunction

" Paste
" Reselect previously yanked text after paste.
xnoremap p pgvy

" Persistent undo.
set undofile
set undodir=~/.vim/undo

" quickfix
autocmd FileType qf nnoremap <buffer> <CR> <CR>  " Remap CR back in {quick,location}list.
autocmd FileType qf wincmd J                     " Place the {quick,location}list on the bottom.

" tabs
set tabstop=8
set shiftwidth=4
set expandtab
set shiftround

" indentaion marks
set list
set listchars=tab:.\ ,eol:¬,trail:·

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
" close buffer without changing window splits
nnoremap <C-c> :bp\|bd #<CR>

vnoremap " <esc><esc>`<i"<esc>`>la"<esc>

"onoremap in( :<c-u>normal! f(vi(<cr>
"onoremap il( :<c-u>normal! F)vi(<cr>

iabbrev @@ kopiczko@gmail.com
iabbrev retunr return
iabbrev reutnr return

if has('mac')       " mac settigns
elseif has('unix')  " linux settings
  let g:netrw_browsex_viewer = 'xdg-open'
endif

" }}}

" clean whitespace & indentation {{{
" Remove trailing wthiespace for following file types.
autocmd FileType bash,c,cpp,go,java,javascript,markdown,php,sh autocmd BufWritePre <buffer> %s/\s\+$//e
" }}}

" python & ruby {{{
"
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
if has('nvim')
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'

  let g:ruby_host_prog = '/usr/local/opt/ruby/bin/ruby'
endif
" }}}

" color theme {{{
" colorscheme PaperColor
colorscheme vylight
" invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set background=light
highlight Visual ctermbg=Grey
" }}}

"execute pathogen#infect()
call plug#begin('~/.local/share/nvim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'bogado/file-line'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-markdown'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()


" tmux navigator {{{
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

" nerdtree {{{
noremap <F2> :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" lightline {{{
let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly' ],
            \             [ 'absolutepath', 'modified' ] ]
            \ },
            \ 'component_function': {
            \     'gitbranch': 'fugitive#head'
            \ },
            \ }
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
"call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#option('omni_patterns', {
            \     'go': '[^. *\t]\.\w*',
            \ })
" }}}

" fzf {{{
" git ls-files -co -x vendor
nnoremap <c-p> :FZF!<CR>
" }}}

" tagbar {{{
nmap <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0
" }}}

" youcompleteme {{{
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<tab>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

set completeopt-=preview
" }}}

" ultisnips {{{
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" }}}

" vim-go {{{
" TODO use gometalinter maybe also consider Neomake
let g:syntastic_go_checkers = ['go', 'govet', 'errcheck'] " , 'golint'
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_addtags_transform = 'camelcase'
let g:go_fmt_command = "goimports"
let g:go_gocode_autobuild = 1
let g:go_metalinter_enabled = 1

augroup vimgo
autocmd!

autocmd FileType go nmap <buffer> <leader>r <Plug>(go-run)
autocmd FileType go nmap <buffer> <leader>d <Plug>(go-doc-browser)
autocmd FileType go nmap <buffer> <C-]> <Plug>(go-def)
"autocmd FileType go nmap <buffer> <C-]> :execute 'YcmCompleter GoTo'<CR>

autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType go command! T GoTest

"autocmd BufWritePost *.go :SyntasticCheck
augroup END

let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
" }}}

" vim-markdown {{{
let g:markdown_fenced_languages = [
            \ "go",
            \ 'bash=sh',
            \ 'html',
            \ 'javascript',
            \ 'python',
            \ ]
let g:markdown_minlines = 100
" }}}

" yaml {{{
augroup my-yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" commands {{{
command! Mkspell call MyMkspell()

command! Q :qa!
" }}}
