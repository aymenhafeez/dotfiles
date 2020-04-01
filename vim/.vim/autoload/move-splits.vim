
" Slightly easier way to move splits around
function! MarkWindow()
    let g:marked_window = winnr()
endfunction

function! SwapWindow()
    " mark current position
    let current_window = winnr()
    let current_buffer = bufnr( "%" )
    execute g:marked_window . "wincmd w"
    let marked_buffer = bufnr( "%" )
    " hide and open so that we aren't prompted and keep history
    execute 'hide buf' current_buffer
    " switch to dest and shuffle source->dest
    execute current_window . "wincmd w"
    execute 'hide buf' marked_buffer
endfunction

nnoremap <silent> <Leader>mw :call MarkWindow()<CR>
nnoremap <silent> <Leader>pw :call SwapWindow()<CR>
