" vim: fdm=marker

if has('nvim')
    let $VIMHOME = $HOME . "/.config/nvim"
else
    let $VIMHOME = $HOME . "/.vim"
endif

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
set mouse=a        " Mouse events for all. Allows nice scrolling in tmux.
set nobackup       " Don't create annoying backup files.
set nowritebackup
set noerrorbells   " No beeps.
set nojoinspaces   " No double space after a dot.
set noshowmode     " Get rid of thing like --INSERT--.
set nosplitright   " Split vertical windows left bo the current windows.
set noswapfile     " Don't use swapfile.
set splitbelow     " Split horizontal windows below to the current windows.
set updatetime=300 " For coc.nvim so CursorHold is faster.

" statusline always visible
set laststatus=2

" scrolling
"" Setting `set scroll=10` doesn't work for me.
"" https://stackoverflow.com/questions/37322720/set-default-scroll-options-in-vim
nnoremap <C-u> 10k
nnoremap <C-d> 10j
vnoremap <C-u> 10k
vnoremap <C-d> 10j

" search
set ignorecase
set smartcase
set hlsearch
set incsearch
"" Map enter to disable search highlight.
nnoremap <silent> <CR> :nohlsearch<CR>

" Paste
" Reselect previously yanked text after paste.
xnoremap p pgvy

" Persistent undo.
set undofile
set undodir=$VIMHOME/undo

" quickfix
autocmd FileType qf nnoremap <buffer> <CR> <CR>  " Remap CR back in {quick,location}list.
autocmd FileType qf wincmd J                     " Place the {quick,location}list on the bottom.

" tabs
set tabstop=8
set shiftwidth=4
set expandtab
set shiftround

" indentation marks
set list
set listchars=tab:.\ ,eol:¬,trail:•

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

let mapleader = "m"
let maplocalleader = "m"

inoremap jk <esc>

" Don't show help with F1.
nnoremap <F1> <NOP>

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <C-a> ^
nnoremap <C-e> $
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A
"nnoremap <M-=> <C-a>
"nnoremap <M--> <C-x>
nnoremap <S-h> :tabp<CR>
nnoremap <S-l> :tabn<CR>
nnoremap j gj
nnoremap k gk
" close buffer without changing window splits
"nnoremap <C-c> :bp\|bd #<CR>
nnoremap <silent> <C-c> :call init#BufCloseAndBack()<CR>

function! init#BufCloseAndBack()
    execute "bd"
    if bufexists("#")
        execute "e " . bufname("#")
    endif
endfunction

vnoremap " <esc><esc>`<i"<esc>`>la"<esc>

iabbrev @@ kopiczko@gmail.com
iabbrev retunr return
iabbrev reutnr return

if has('mac')       " mac settigns
elseif has('unix')  " linux settings
  let g:netrw_browsex_viewer = 'xdg-open'
endif

" }}}

" Spell {{{
set spellcapcheck= " Allow sentences starting with lower letter
"set spelllang=en
set spell

"set spellfile=~/.vim/unsorted.utf-8.add

function init#MyMkspell(path)
    execute 'mkspell! '.a:path.'.spl '.a:path
endfunction

function s:InitSpell()
    let dir = fnamemodify($MYVIMRC, ':p:h') . '/spell'
    let files = globpath(dir, '*.utf-8.add')
    let files = substitute(files, '\n', ',', 'g')
    let &spellfile = files
endfunction

call s:InitSpell()

augroup init_spell
    autocmd!
    autocmd BufWritePost *.utf-8.add :call init#MyMkspell(expand('%:p'))
augroup END

" }}}

" Clean trailing spaces {{{ 
" Remove trailing whitespace for following file types.
autocmd FileType bash,c,cpp,go,java,javascript,markdown,php,sh autocmd BufWritePre <buffer> %s/\s\+$//e
" }}}

" python & ruby {{{
"
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
if has('nvim')
  "let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'

  let g:ruby_host_prog = '/usr/local/opt/ruby/bin/ruby'
endif
" }}}

"execute pathogen#infect()
call plug#begin('~/.local/share/nvim/plugged')

Plug 'SirVer/ultisnips'
Plug 'bogado/file-line'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cormacrelf/vim-colors-github'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'tag': 'v0.0.78'}
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'

call plug#end()

" denite {{{
" First part is to prevent from opening files in NERDTree buffer.
nnoremap <silent><expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Denite buffer file/rec<CR>"

nnoremap <silent> <leader><leader> :Denite menu<CR>
vnoremap <silent> <leader><leader> :Denite menu:tabular<CR>

" Add custom menus
let s:menus = {}
let s:menus.vim = {
            \ 'description': 'VIM utils',
            \ }
let s:menus.vim.command_candidates = [
            \ ['Edit init.vim', 'e $MYVIMRC'],
            \ ['Source init.vim', 'source $MYVIMRC'],
            \ ]
let s:menus.ultisnips = {
            \ 'description': 'Some tabular commands',
            \ }
let s:menus.ultisnips.command_candidates = [
            \ ['Edit Bash/sh snippets', 'UltiSnipsEdit bash'],
            \ ['Edit Go snippets', 'UltiSnipsEdit go'],
            \ ]
let s:menus.tabular = {
            \ 'description': 'Some tabular commands',
            \ }
let s:menus.tabular.command_candidates = [
            \ ['Align by |', 'Tab /|'],
            \ ['Align by =', 'Tab /='],
            \ ['Align by : (: stays on the left)', 'Tab /:\zs'],
            \ ['Align by ,', 'Tab /,'],
            \ ['Align by " (useful for VimL comments)', 'Tab /"'],
            \ ]

"let s:menus.zsh.file_candidates = [
"        \ ['zshrc', '~/.config/zsh/.zshrc'],
"        \ ['zshenv', '~/.zshenv'],
"        \ ]
"
"let s:menus.my_commands = {
"        \ 'description': 'Example commands'
"        \ }
"let s:menus.my_commands.command_candidates = [
"        \ ['Split the window', 'vnew'],
"        \ ['Open zsh menu', 'Denite menu:zsh'],
"        \ ['Format code', 'FormatCode', 'go,python'],
"        \ ]

call denite#custom#var('menu', 'menus', s:menus)

" Use ag for listing files.
call denite#custom#var('file/rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" Sort files using Sublime sorter.
call denite#custom#source(
    \ 'file/rec', 'sorters', ['sorter/sublime'])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> d
      \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
      \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
      \ denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
      \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <CR>
      \ denite#do_map('do_action')

  " Move up/down with arrows and C-j/C-k.
  inoremap <silent><buffer><expr> <C-j>
      \ denite#increment_parent_cursor(1)
  inoremap <silent><buffer><expr> <C-k>
      \ denite#increment_parent_cursor(-1)
  nnoremap <silent><buffer><expr> <C-j>
      \ denite#increment_parent_cursor(1)
  nnoremap <silent><buffer><expr> <C-k>
      \ denite#increment_parent_cursor(-1)
  inoremap <silent><buffer><expr> <Down>
      \ denite#increment_parent_cursor(1)
  inoremap <silent><buffer><expr> <Up>
      \ denite#increment_parent_cursor(-1)
  nnoremap <silent><buffer><expr> <Down>
      \ denite#increment_parent_cursor(1)
  nnoremap <silent><buffer><expr> <Up>
      \ denite#increment_parent_cursor(-1)
endfunction
" }}}

" color theme {{{
" colorscheme PaperColor
" colorscheme vylight
" colorscheme base16-google-light
colorscheme github
set nocursorline
" invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set background=light
highlight Visual ctermbg=Grey
" }}}

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
"nnoremap <F2> :NERDTreeFind<CR>
nnoremap <silent> <expr> <F2> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
autocmd StdinReadPre * let s:std_in=1
" Open NERDTree on startup.
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Quit when NERDTree is the only open buffer.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1
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

" tagbar {{{
nmap <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_compact = 1

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
let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
            \ 'h:headers'
            \ ],
            \ 'sort' : 0,
            \ }
let g:tagbar_type_terraform = {
            \ 'ctagstype' : 'terraform',
            \ 'kinds' : [
            \ 'r:resources',
            \ 'm:modules',
            \ 'o:outputs',
            \ 'v:variables',
            \ 'f:tfvars'
            \ ],
            \ 'sort' : 0
            \ }
let g:tagbar_type_yaml = {
            \ 'ctagstype' : 'yaml',
            \ 'kinds' : [
            \ 'a:anchors',
            \ 's:section',
            \ 'e:entry'
            \ ],
            \ 'sro' : '.',
            \ 'scope2kind': {
            \ 'section': 's',
            \ 'entry': 'e'
            \ },
            \ 'kind2scope': {
            \ 's': 'section',
            \ 'e': 'entry'
            \ },
            \ 'sort' : 0
            \ }
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

autocmd FileType go nnoremap <buffer> <leader>r <Plug>(go-run)
autocmd FileType go nnoremap <buffer> <leader>d <Plug>(go-doc-browser)
autocmd FileType go nnoremap <buffer> <C-]> <Plug>(coc-definition)
autocmd FileType go inoremap <silent><expr> <C-x><C-o> coc#refresh()
"autocmd FileType go nmap <buffer> <C-]> :execute 'YcmCompleter GoTo'<CR>

autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType go command! T GoTest

"autocmd BufWritePost *.go :SyntasticCheck
augroup END

" }}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:markdown_fenced_languages = [
            \ "go",
            \ 'bash=sh',
            \ "diff",
            \ 'html',
            \ 'javascript',
            \ 'json',
            \ 'python',
            \ 'yaml',
            \ ]
let g:markdown_minlines = 200
" }}}

" vim-sneak {{{
map f <Plug>Sneak_f
map F <Plug>Sneak_F
let g:sneak#use_ic_scs = 1
" }}}

" vim-terraform {{{

let g:terraform_align=1
let g:terraform_fmt_on_save=1

" }}}

" {{{ plugin: indentLine
" Example characters: ¦ ┆ │ ⎸ ▏
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '⎸'
" }}}

" yaml {{{
augroup my-yaml
autocmd BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent foldlevel=100
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}

" commands {{{
command! Mkspell call init#MyMkspell()
command! Q :qa!
command! Cp :let @+ = expand("%:p")
" }}}
