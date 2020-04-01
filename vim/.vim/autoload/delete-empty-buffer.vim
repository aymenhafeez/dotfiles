
" Close all empty buffers
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufloaded(i) && bufname(i) == '' && getbufline(i, 1, 2) == ['']
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

nnoremap <silent> <Leader>cb :call DeleteEmptyBuffers()<CR>
