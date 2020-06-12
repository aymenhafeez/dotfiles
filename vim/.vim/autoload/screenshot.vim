

" take a screenshot quickly while making notes
function! screenshot#screenshot() abort
    let file_name = input("File name: ")
    execute '!scrot -s $PWD/' . file_name
endfunction
