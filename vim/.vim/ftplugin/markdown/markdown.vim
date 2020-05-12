" Settings and mappings for Markdown
" ----------------------------------

set tabstop=2
set shiftwidth=2
set expandtab
set tw=80
set fo+=t
setlocal spell!
set conceallevel=1

nnoremap <buffer> <leader>mk :InstantMarkdownPreview<CR>

" convert to pdf with pandoc
nnoremap <buffer> <leader>cm :!pandoc -s -o %:t:r.pdf %<CR><CR>
" convert to pdf with pandoc and open pdf
nnoremap <buffer> <leader>pv :!clear && pandoc -s -o %:t:r.pdf % && nohup zathura %:t:r.pdf &<CR><CR>

" close environments
inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
inoremap <buffer> ]e <Esc>mt?begin<CR>yy`tpwciwend<Esc>A
nnoremap <buffer> ]] mt?begin<CR>yy`tpwciwend<Esc>

verbose abbreviate CO2 CO<sub>2</sub>
