
" Fix the last spelling error (from christoomey's vim plugin talk)
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

nnoremap <Leader>sf :call FixLastSpellingError()<CR>
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
