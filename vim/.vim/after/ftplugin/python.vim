" Python settings and mappings

" run file
nnoremap <localleader>py :%w !python3<CR>

" run visual selection
xnoremap <localleader>p :%w !python3<CR>

nnoremap <localleader>x Vgg:%w !python3<CR>

" complete hack to work with IPython.
function! GetFilePath()
    let @" = '%run ' . expand("%:p")
endfunction

nnoremap <C-c><C-p> :rightbelow terminal ++close ++rows=11 ipython<CR><C-w>k
nnoremap <C-c><C-c> :call GetFilePath()<CR>:wincmd j<CR><C-w>""<CR><C-w>k
vnoremap <C-c><C-c> y:wincmd j<CR><C-w>"+<CR><C-w>k

" linting
setlocal makeprg=pylint\ --output-format=parseable
command! -nargs=0 Lint :make %

" wmvanvliet/jupyter-vim 
" ----------------------
nnoremap <buffer> <silent> <localleader>R :JupyterRunFile<CR>
nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>
nnoremap <buffer> <silent> <localleader>co :JupyterConnect<CR>

" Change to directory of current file
nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>

" Send a selection of lines
nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>E :1,.JupyterSendRange<CR>
nnoremap <buffer> <silent> <localleader>T <Plug>JupyterRunTextObj
vnoremap <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

nnoremap <buffer> <silent> <localleader>U :JupyterUpdateShell<CR>

" Debugging
nnoremap <buffer> <silent> <localleader>Br :PythonSetBreak<CR>
