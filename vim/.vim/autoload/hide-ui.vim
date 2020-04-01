
" hide ui elements
let s:hidden_all=1
function! ToggleHideAll() abort
    if s:hidden_all==0
        let s:hidden_all=1
        set showmode
        set ruler
        set laststatus=0
        set showcmd
    else
        let s:hidden_all=0
        set noshowmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <silent> <leader>hi :call ToggleHideAll()<CR>
