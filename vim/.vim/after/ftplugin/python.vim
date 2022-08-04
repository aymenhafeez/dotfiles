" Python settings and mappings

" run file
nnoremap <localleader>py :%w !python3<CR>

" run visual selection
xnoremap <localleader>p :%w !python3<CR>

" run everything til the cursor position
nnoremap <localleader>x Vgg:%w !python3<CR>

" sending code to IPython (very janky)
function! GetFilePath()
    let @" = '%run ' . expand("%:p")
endfunction

nnoremap <C-c><C-p> :rightbelow terminal ++close ++rows=11 ipython<CR><C-w>k
nnoremap <C-c><C-c> :call GetFilePath()<CR>:wincmd w<CR><C-w>""<CR><C-w>w
vnoremap <C-c><C-c> y:wincmd w<CR><C-w>""<CR><C-w>w


" linting
setlocal makeprg=pylint\ --output-format=parseable
command! -nargs=0 Lint :make %
