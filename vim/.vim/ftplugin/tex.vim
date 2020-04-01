" Settings and mappings for TeX

set tabstop=4
set shiftwidth=4
set expandtab
set tw=80
set fo+=t
setlocal spell!
set conceallevel=1
let g:tex_conceal='abdmg'

" close environments
inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
inoremap <buffer> ]e <Esc>mt?begin<CR>yy`tpwciwend<Esc>A
nnoremap <buffer> ]] mt?begin<CR>yy`tpwciwend<Esc>

inoremap <buffer> <C-c><C-j> <Esc>o\item 

" compile and update pdf
nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex %<CR><CR>
" open in zathura
nnoremap <buffer> <silent> <Leader>pv :w!<CR>:!clear && pdflatex % && nohup zathura %:t:r.pdf &<CR><CR>
