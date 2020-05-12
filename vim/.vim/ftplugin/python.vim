" python settings and mappings

" run file
nnoremap <leader>py :%w !python3<CR>

" run visual selection
xnoremap <leader>p :%w !python3<CR>

nnoremap <leader>x Vgg:%w !python3<CR>

" complete hack to work with IPython.
function! GetFilePath()
    let @" = '%run ' . expand("%:p")
    echo 'File path copied to " register'
endfunction
nnoremap yZ :call GetFilePath()<CR>

nnoremap <C-c><C-p> :rightbelow terminal ++close ++rows=11 ipython<CR><C-w>k
nnoremap <C-c><C-c> :call GetFilePath()<CR>:wincmd j<CR><C-w>""<CR><C-w>k
