" let g:toggle_term = "<leader>tt"

" let g:term_buf_nr = -1
" function! ToggleTerminal()
"     if g:term_buf_nr == -1
"         execute "bot term"
"         let g:term_buf_nr = bufnr("$")
"     else
"         execute "bd! " .g:term_buf_nr
"         let g:term_buf_nr = -1
"     endif
" endfunction

" execute "nnoremap ".g:toggle_term ." :call ToggleTerminal()<CR>"
