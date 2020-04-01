" ---------------------------------- mappings ---------------------------------

nnoremap Y y$

" open help contents for installed plugins
nnoremap <leader>rh :help local-additions<CR>

" toggle and untoggle spell checking
nnoremap <leader>spl :setlocal spell!<CR>

" netrw
nnoremap <Leader>- :Explore %:p:h<CR>
nnoremap s- :Sexplore %:p:h<CR>
nnoremap v- :Vexplore %:p:h<CR>
nnoremap <leader>- :Lexplore<CR>:call DeleteEmptyBuffers()<CR>

nnoremap - :NERDTreeToggle<CR>

nnoremap <leader>e :e **/*<C-z><S-Tab><C-z>
nnoremap <leader>f :find **/*<C-z><S-Tab><C-z>

nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>

nnoremap <leader>do :e ~/Documents/<C-z>
nnoremap <leader>no :e ~/Documents/notes/<C-z>
nnoremap <leader>vi :e ~/.vim/<C-z>
nnoremap <leader>vc :e $MYVIMRC<CR>

nnoremap sb :%s///g<left><left><left>
nnoremap sg yiw:%s/<C-R>"//g<left><left>

nnoremap <leader>so :source %<CR>

nnoremap <leader>bo :browse oldfiles<cr>

" search for key words in notes and open tex file
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <leader>[ :Ngrep 

nnoremap <Tab> >>
nnoremap <S-Tab> <<

inoremap <C-a> <C-o>^
inoremap <C-x><C-a> <C-a>
inoremap <C-e> <Esc>A
inoremap <C-d> <Esc>lxi
inoremap <C-b> <Left>
inoremap <C-f> <Right>

vnoremap <Tab> >
vnoremap <S-Tab> <

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-x><C-a> <C-a>

cnoremap ls<CR> buffers<CR>:buffer 
