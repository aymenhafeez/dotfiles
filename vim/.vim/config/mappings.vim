" ---------------------------------- mappings ---------------------------------

" move through wrapped lines
nnoremap j gj
nnoremap k gk
noremap gj j
noremap gk k

" save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" copy file path
nnoremap <silent> yZ :let @" = expand("%:p")<CR>

" copy filename
nnoremap <silent> yY :let @" = expand("%")<CR>

" open help contents for installed plugins
nnoremap <Leader>rh :help local-additions<CR>

" toggle and untoggle spell checking
nnoremap <Leader>spl :setlocal spell!<CR>

nnoremap <Leader>f :find *

" open empty split panes
nnoremap <silent> <Leader>wh :leftabove vnew<CR>
nnoremap <silent> <Leader>wl :rightbelow vnew<CR>
nnoremap <silent> <Leader>wk :leftabove new<CR>
nnoremap <silent> <Leader>wj :rightbelow new<CR>

nnoremap <silent> <Leader>swh :topleft vnew<CR>
nnoremap <silent> <Leader>swl :botright vnew<CR>
nnoremap <silent> <Leader>swk :topleft new<CR>
nnoremap <silent> <Leader>swj :botright new<CR>
