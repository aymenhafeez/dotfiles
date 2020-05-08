" Mappings

nnoremap Y y$

nnoremap <silent> <esc><esc> :nohls<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" toggle and untoggle spell checking
nnoremap <leader>spl :setlocal spell!<CR>

" netrw
nnoremap <silent> - :Explore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> <leader>- :Lexplore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> s- :Sexplore<CR>
nnoremap <silent> v- :Vexplore<CR>

" nnoremap <leader>e :e **/*<C-z>
" nnoremap <leader>f :find **/*<C-z>
nnoremap <leader>f :Files<CR>

" nnoremap <leader>b :buffers<CR>:buffer 
nnoremap <leader>b :Buffers<CR>

" frequent directories
nnoremap <leader>do :Lexplore ~/Documents/<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <leader>no :Lexplore ~/Documents/notes/<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <leader>vi :Lexplore ~/.vim/<CR>:call DeleteEmptyBuffers()<CR> 

" search and replace
nnoremap sb :%s///g<left><left><left>
nnoremap sg yiw:%s/<C-R>"//g<left><left>
nnoremap sc yiw:%s/<C-R>"//c<left><left>

" source current file
nnoremap <silent> <leader>so :source %<CR>:nohls<CR>

" remove trailing whitespace
nnoremap <silent> <leader>wh :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" search for key words in notes and open tex file
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <leader>[ :Ngrep 

nnoremap <leader>sc :Scratch<CR>
nnoremap <leader>ss :Sscratch<CR>

" Readline bindings in insert mode
inoremap <C-a> <C-o>^
inoremap <C-x><C-a> <C-a>
inoremap <C-e> <Esc>A
inoremap <C-d> <Esc>lxi
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" fix previous spelling error
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

" Readline navigation in command-line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-x><C-a> <C-a>

" source visual selection
xnoremap <leader>so :<C-u>@*<CR>
