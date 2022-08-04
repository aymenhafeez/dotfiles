
function! help#helpfilemode()
  wincmd L " Maximze the help on open
  nnoremap <buffer> <tab> :call search('\|.\{-}\|', 'w')<cr>:noh<cr>2l
  nnoremap <buffer> <S-tab> F\|:call search('\|.\{-}\|', 'wb')<cr>:noh<cr>2l
  setlocal nonumber
endfunction


" scrolling in help files
nnoremap <buffer> <down> <C-e>j
nnoremap <buffer> <up> <C-y>k
