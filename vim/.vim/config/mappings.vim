" ---------------------------------- mappings ---------------------------------

" save and run Python files
nnoremap <leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" slightly faster scrolling
nnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>

" open help contents for installed plugins
nnoremap <leader>rh :help local-additions<CR>

" toggle and untoggle spell checking
nnoremap <leader>spl :setlocal spell!<CR>

" open empty split panes
nnoremap <silent> <leader>wh :leftabove vnew<CR>
nnoremap <silent> <leader>wl :rightbelow vnew<CR>
nnoremap <silent> <leader>wk :leftabove new<CR>
nnoremap <silent> <leader>wj :rightbelow new<CR>

nnoremap <silent> <leader>swh :topleft vnew<CR>
nnoremap <silent> <leader>swl :botright vnew<CR>
nnoremap <silent> <leader>swk :topleft new<CR>
nnoremap <silent> <leader>swj :botright new<CR>

" netrw
nnoremap - :Explore %:p:h<CR>
nnoremap s- :Sexplore %:p:h<CR>
nnoremap v- :Vexplore %:p:h<CR>
nnoremap <C-n> :Lexplore<CR>:call DeleteEmptyBuffers()<CR>

nnoremap <leader>e :e **/*<C-z><S-Tab><C-z>
nnoremap <leader>f :find **/*<C-z><S-Tab><C-z>

nnoremap <leader>do :e ~/Documents/<C-z>
nnoremap <leader>no :e ~/Documents/notes/<C-z>
nnoremap <leader>vi :e ~/.vim/<C-z>
nnoremap <leader>vc :e $MYVIMRC<CR>

nnoremap sub :%s///g<left><left><left>

nnoremap <leader>so :source %<CR>

command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <leader>[ :Ngrep 

nnoremap <buffer> <leader>R :JupyterConnect<CR>
nnoremap <buffer> <silent> <leader>I :PythonImportThisFile<CR>

" Change to directory of current file
nnoremap <buffer> <silent> <leader>d :JupyterCd %:p:h<CR>

" Send a selection of lines
nnoremap <buffer> <silent> <leader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <leader>E :JupyterSendRange<CR>
nmap     <buffer> <silent> <leader>e <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <leader>e <Plug>JupyterRunVisual

nnoremap <buffer> <silent> <leader>U :JupyterUpdateShell<CR>

" Debugging maps
nnoremap <buffer> <silent> <leader>b :PythonSetBreak<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
