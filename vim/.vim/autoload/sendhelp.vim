
" look through help for word under cursor
function! sendhelp#help() abort
    normal! "hyiw:help <C-r>h<CR>
endfunction
nmap <leader>hh "hyiw:help <C-r>h<CR>
