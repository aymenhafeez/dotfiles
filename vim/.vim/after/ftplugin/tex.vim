" Settings and mappings for TeX

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

" " compile and update pdf
" nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex %<CR><CR>
" " open pdf preview
" nnoremap <buffer> <silent> <Leader>pv :w!<CR>:!clear && pdflatex % && nohup open %:t:r.pdf &<CR><CR>

nnoremap <leader>cm :call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-w>"".tex<CR><C-w>w
nnoremap <leader>pv :call GetFilePath()<CR>:FloatermToggle<CR>pdflatex <C-w>"".tex<CR>zathura <C-w>"".pdf &<CR><C-w>w


