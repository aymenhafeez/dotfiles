
" copy filename
function! CopyFileName()
    let @" = expand("%")
    echo 'File name copied to " register'
endfunction

nnoremap yY :call CopyFileName()<CR>
