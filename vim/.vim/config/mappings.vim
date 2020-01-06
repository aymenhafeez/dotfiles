" ---------------------------------- mappings ---------------------------------

" save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" copy file path
nnoremap <silent> yZ :let @" = expand("%:p")<CR>

" copy filename
nnoremap <silent> yY :let @" = expand("%")<CR>

" slightly faster scrolling
nnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>

" open help contents for installed plugins
nnoremap <Leader>rh :help local-additions<CR>

" toggle and untoggle spell checking
nnoremap <Leader>spl :setlocal spell!<CR>

" open empty split panes
nnoremap <silent> <Leader>wh :leftabove vnew<CR>
nnoremap <silent> <Leader>wl :rightbelow vnew<CR>
nnoremap <silent> <Leader>wk :leftabove new<CR>
nnoremap <silent> <Leader>wj :rightbelow new<CR>

nnoremap <silent> <Leader>swh :topleft vnew<CR>
nnoremap <silent> <Leader>swl :botright vnew<CR>
nnoremap <silent> <Leader>swk :topleft new<CR>
nnoremap <silent> <Leader>swj :botright new<CR>

" netrw
nnoremap - :Explore %:p:h<CR>
nnoremap <silent> s- :Sexplore %:p:h<CR>
nnoremap <silent> v- :Vexplore %:p:h<CR>
nnoremap <silent> <C-n> :Lexplore<CR>:call DeleteEmptyBuffers()<CR>

nnoremap <Leader>e :e **/*<C-z><S-Tab><C-z>
nnoremap <Leader>f :find **/*<C-z><S-Tab><C-z>

noremap <silent> <Leader>so :so %<CR>

" visual selection search with ?
" cnoremap <expr> <space> getcmdtype() == "?" ? ".*" : "<space>"
cnoremap <expr> <space> '/?' =~ getcmdtype() ? ".*\\_s*.*" : "<space>"
