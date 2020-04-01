
" copy file path
function! CopyFilePath()
    let @" = expand("%:p")
    echo 'File path copied to " register'
endfunction

nnoremap yZ :call CopyFilePath()<CR>
