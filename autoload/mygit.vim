let s:win_width = 40
let s:win_min_height = 5

function s:WinSetHeight(win, buf) abort
    let cnt = nvim_buf_line_count(a:buf)
    if cnt < s:win_min_height
        let cnt = s:win_min_height
    endif
    call nvim_win_set_height(a:win, cnt)
endfunction

function s:GitBranchDelete() abort
    let branch = nvim_get_current_line()[2:]
    if nvim_get_current_line()[0:0] ==# '*'
        echomsg 'Error: Branch '.branch.' is the current branch'
        return
    endif
    if branch ==# 'master'
        echomsg 'Error: Deleting '.branch.' branch is forbidden'
        return
    endif
    set noreadonly
    execute 'normal! dd'
    set readonly
    call s:WinSetHeight(nvim_get_current_win(), nvim_get_current_buf())
    execute 'Git branch -D '.branch
endfunction

function s:GitCheckout() abort
    let branch = nvim_get_current_line()[2:]
    bd!
    execute 'Git checkout '.branch
endfunction

function mygit#Branches() abort
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
