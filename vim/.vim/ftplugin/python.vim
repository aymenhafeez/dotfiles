" python settings

let g:syntastic_python_checkers = ['flake8']

" run file
nnoremap <leader>py :%w !python3<CR>

" run visual selection
xnoremap <leader>p :%w !python3<CR>

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
nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
nnoremap     <buffer> <silent> <localleader>T <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

nnoremap <buffer> <silent> <localleader>U :JupyterUpdateShell<CR>

" Debugging maps
nnoremap <buffer> <silent> <localleader>B :PythonSetBreak<CR>
