" Mappings

nnoremap Y y$

" disable higlighting search matches
nnoremap <silent> <esc><esc> :nohls<CR>

" toggle and untoggle spell checking
nnoremap <leader>spl :setlocal spell!<CR>

" netrw
nnoremap <silent> - :Explore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> <leader>- :Lexplore<CR>:call DeleteEmptyBuffers()<CR>
nnoremap <silent> s- :Sexplore<CR>
nnoremap <silent> v- :Vexplore<CR>

" access files recursively
nnoremap <leader>e :e **/*<C-z>
nnoremap <leader>f :find **/*<C-z>

nnoremap <leader>b :buffers<CR>:buffer 

" search and replace
nnoremap sb :%s///g<left><left><left>
nnoremap sg yiw:%s/<C-r>"//g<left><left>
nnoremap sc yiw:%s/<C-r>"//c<left><left>

" source current file
nnoremap <silent> <leader>so :source %<CR>

" remove trailing whitespace (from the vimwiki)
nnoremap <silent> <leader>wh :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" search for key words in notes and open .tex file (from nixcasts' config)
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/**/*.tex
nnoremap <leader>[ :Ngrep 

" fix previous spelling error from insert mode
inoremap <C-s> <C-g>u<Esc>[s1z=`]a<C-g>u

" commnand-line editing (from :h Command-line-editing)
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" source visual selection
xnoremap <leader>so :<C-u>@*<CR>
