" mappings
" ========

nnoremap Y y$

" scroll with cursor
nnoremap <C-DOWN> <C-e>j
nnoremap <C-UP> <C-y>k

" open help contents for installed plugins
nnoremap <leader>rh :help local-additions<CR>

" toggle and untoggle spell checking
nnoremap <leader>spl :setlocal spell!<CR>

" netrw
nnoremap <silent> - :Explore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> <leader>- :Lexplore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> s- :Sexplore<CR>
nnoremap <silent> v- :Vexplore<CR>

nnoremap <leader>e :e **/*<C-z>
nnoremap <leader>f :find **/*<C-z>

nnoremap <leader>b :buffers<CR>:buffer 

nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>g :grep<space>
nnoremap <leader>i :Ilist<space>

" frequent directories
nnoremap <leader>do :Lexplore ~/Documents/<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <leader>no :Lexplore ~/Documents/notes/<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <leader>vi :Lexplore ~/.vim/<CR>:call DeleteEmptyBuffers()<CR> 

" open recent file
nnoremap <leader>o :browse oldfiles<cr>

nnoremap sb :%s///g<left><left><left>

" replace all instances of the  word under the cursor
nnoremap sg yiw:%s/<C-R>"//g<left><left>
nnoremap sc yiw:%s/<C-R>"//c<left><left>

nnoremap <leader>so :source %<CR>

" toggle linting
nnoremap <leader>ad :ALEDisable<CR>
nnoremap <leader>ae :ALEEnable<CR>

" remove trailing whitespace
nnoremap <silent> <leader>wh :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" search for key words in notes and open tex file
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <leader>[ :Ngrep 

nnoremap <Tab> >>
nnoremap <S-Tab> <<

nnoremap <leader>sc :Scratch<CR>
nnoremap <leader>ss :Sscratch<CR>

" emacs like bindings in inser mode
inoremap <C-a> <C-o>^
inoremap <C-x><C-a> <C-a>
inoremap <C-e> <Esc>A
inoremap <C-d> <Esc>lxi
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" fix previous spelling error
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

" easier navigation is command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-x><C-a> <C-a>

" terminal navigation
tnoremap <C-k> <C-w>k
tnoremap <C-j> <C-w>j
tnoremap <C-h> <C-w>h
tnoremap <C-l> <C-w>l

" source visual selection
xnoremap <leader>so :<C-u>@*<CR>
