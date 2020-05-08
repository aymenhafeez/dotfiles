" python settings

" let g:syntastic_python_checkers = ['flake8']
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']

" run file
nnoremap <leader>py :%w !python3<CR>

" run visual selection
xnoremap <leader>p :%w !python3<CR>

" jpalardy/vim-slime 
" ------------------
" " send entire file
" nnoremap <leader>R :%SlimeSend<CR>
" " send till the current line
" nnoremap <leader>B :1,.SlimeSend<CR>
" " send current line
" nnoremap <leader>E :.SlimeSend<CR>

" wmvanvliet/jupyter-vim 
" ----------------------
if has('nvim')
    let g:python3_host_prog = '/usr/bin/python3'
else
    set pyxversion=3

    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/Python
endif

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

function! CopyFilePath()
    let @" = '%run ' . expand("%:p")
    echo 'File path copied to " register'
endfunction
nnoremap yZ :call CopyFilePath()<CR>

nnoremap <C-c><C-p> :rightbelow terminal ++close ++rows=11 ipython<CR><C-w>k
nnoremap <C-c><C-c> :call CopyFilePath()<CR>:wincmd j<CR><C-w>""<CR><C-w>k
