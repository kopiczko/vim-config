let s:win_width = 40
let s:win_min_height = 5

function! s:WinSetHeight(win, buf) abort
    let cnt = nvim_buf_line_count(a:buf)
    if cnt < s:win_min_height
        let cnt = s:win_min_height
    endif
    call nvim_win_set_height(a:win, cnt)
endfunction

function! s:GitBranchDelete() abort
    let branch = nvim_get_current_line()[2:]
    if nvim_get_current_line()[0:0] ==# '*'
        echoerr 'Error: Branch '.branch.' is the current branch'
        return
    endif
    if branch ==# 'master'
        echoerr 'Error: Deleting '.branch.' branch is forbidden'
        return
    endif
    set noreadonly
    execute 'normal! dd'
    set readonly
    call s:WinSetHeight(nvim_get_current_win(), nvim_get_current_buf())
    execute 'Git branch -D '.substitute(branch, '#', '\\#', 'g')
endfunction

function! s:GitCheckout() abort
    let branch = nvim_get_current_line()[2:]
    bd!
    execute 'Git checkout '.branch
endfunction

function! mygit#Branches() abort
    let buf = nvim_create_buf(v:false, v:true)
    let opts = {'relative': 'editor', 'width': s:win_width, 'height': &lines, 'col': &columns/2-s:win_width/2,
                \ 'row': 5, 'anchor': 'NW', 'style': 'minimal'}
    let win = nvim_open_win(buf, 0, opts)
    call nvim_set_current_win(win)

    setlocal colorcolumn=0
    setlocal cursorline
    nnoremap <buffer><silent> <CR> :call <SID>GitCheckout()<CR>
    nnoremap <buffer><silent> d :call <SID>GitBranchDelete()<CR>
    nnoremap <buffer><silent> <Esc> :bd!<CR>
    nnoremap <buffer><silent> q :bd!<CR>

    read !git branch
    execute "normal! ggdd"
    setlocal readonly

    call s:WinSetHeight(win, buf)
endfunction

function! mygit#Command(line1, line2, range, bang, mods, arg) abort
    if a:arg =~# '^d$\|^dc$\|^diff$\|^d \|^dc \|^diff \|^lg$\|^log$\|^push$'
        execute 'edit term://git '.a:arg
        setlocal nonumber nospell
        nnoremap <buffer><silent> q :bd!<CR>
        tnoremap <buffer><silent> q <C-\><C-n>:bd!<CR>
    elseif a:arg =~# '^b$\|^branch$'
        call mygit#Branches()
    elseif a:arg =~# '^s$\|^st$\|^status$'
        execute 'Gstatus'
        only
        nnoremap <buffer><silent> q :bd!<CR>
    else
        call fugitive#Command(a:line1, a:line2, a:range, a:bang, a:mods, a:arg)
    endif
endfunction
