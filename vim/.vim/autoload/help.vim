
" Mappings for when using :help user-manual
function! HelpFileHelp()
    wincmd _
    nnoremap <buffer> <tab> :call search('\|.\{-}\|', 'w')<CR>:noh<CR>2l
    nnoremap <buffer> <S-tab> F\|:call search('\|.\{-}\|', 'wb')<CR>:noh<CR>2l
    nnoremap <buffer> <CR> <C-]>
    nnoremap <buffer> <BS> <C-t>
    nnoremap <silent> <buffer> q :q<CR>
    setlocal nonumber
endfunction
