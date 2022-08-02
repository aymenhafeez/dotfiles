
function! GetFilePath()
    let @" = expand("%:t:r")
endfunction

set tabstop=4
set shiftwidth=4
set expandtab
set tw=80
set fo+=t
setlocal spell!
set conceallevel=2
setlocal complete+=kspell
let g:tex_conceal='abdmg'

" " close environments
" inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
" inoremap <buffer> ]e <Esc>mt?begin<CR>yy`tpwciwend<Esc>A
" nnoremap <buffer> <leader>]] mt?begin<CR>yy`tpwciwend<Esc>

inoremap <buffer> <C-c><C-j> <Esc>o\item 
inoremap <buffer> <C-c><C-k> <Esc>O\item 
nnoremap <buffer> <C-c><C-l> i\left<Esc>l%i\right<Esc>
nnoremap <buffer> <C-c><C-j> <Esc>o\item 
nnoremap <buffer> <C-c><C-k> <Esc>O\item 

" open a terminal
" nnoremap <leader>tt :rightbelow terminal ++close ++rows=7<CR>
" compile and update pdf
" nnoremap <C-c><C-c> :rightbelow terminal ++close ++rows=7<CR><C-w>k<CR>:call GetFilePath()<CR>:wincmd j<CR>pdflatex <C-w>"".tex<CR>
" nnoremap <C-c><C-p> :rightbelow terminal ++close ++rows=7<CR><C-w>k<CR>:call GetFilePath()<CR>:wincmd j<CR>open <C-w>"".pdf<CR>

" " compile and update pdf
" nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex %<CR><CR>
" " open pdf preview
" nnoremap <buffer> <silent> <Leader>pv :w!<CR>:!clear && pdflatex % && nohup open %:t:r.pdf &<CR><CR>

nnoremap <buffer> <silent> <leader>cm :call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\><C-n>""pA.tex<CR>
nnoremap <buffer> <silent> <leader>pv :call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-\><C-n>""pA.tex<CR>open <C-\><C-n>""pA.pdf<CR>

