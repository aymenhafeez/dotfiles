" ---------------------------------- mappings ---------------------------------

" save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

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
nnoremap s- :Sexplore %:p:h<CR>
nnoremap v- :Vexplore %:p:h<CR>
nnoremap <C-n> :Lexplore<CR>:call DeleteEmptyBuffers()<CR>

nnoremap <Leader>e :e **/*<C-z><S-Tab><C-z>
nnoremap <Leader>f :find **/*<C-z><S-Tab><C-z>

nnoremap <Leader>do :e ~/Documents/<C-z>
nnoremap <Leader>no :e ~/Documents/notes/<C-z>
nnoremap <Leader>vi :e ~/.vim/<C-z>
nnoremap <Leader>vc :e $MYVIMRC<CR>

nnoremap sub :%s///g<left><left><left>

nnoremap <Leader>so :source %<CR>

command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <Leader>[ :Ngrep 

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
