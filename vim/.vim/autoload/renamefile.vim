
" rename the current file
function! renamefile#rename() abort
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        execute ':saveas ' . new_name
        execute ':silent !rm ' . old_name
        redraw!
    endif
endfunction
