" let s:term_buf_nr = -1
" function! s:ToggleTerminal() abort
"     if s:term_buf_nr == -1
"         execute "botright terminal"
"         let s:term_buf_nr = bufnr("$")
"     else
"         try
"             execute "bdelete! " . s:term_buf_nr
"         catch
"             let s:term_buf_nr = -1
"             call <SID>ToggleTerminal()
"             return
"         endtry
"         let s:term_buf_nr = -1
"     endif
" endfunction

