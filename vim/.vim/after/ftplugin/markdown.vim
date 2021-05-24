" Settings and mappings for Markdown
" ----------------------------------

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal tw=80
setlocal fo+=t
setlocal spell!
setlocal foldcolumn=0
setlocal conceallevel=3

nnoremap <buffer> <leader>mk :MarkdownPreview<CR>

" convert to pdf with pandoc
nnoremap <buffer> <leader>cm :!pandoc -o %:t:r.pdf %<CR><CR>
" convert to pdf with pandoc and open pdf
nnoremap <buffer> <leader>pv :!clear && pandoc -s -o %:t:r.pdf % && nohup xdg-open %:t:r.pdf &<CR><CR>

" close environments
inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
inoremap <buffer> ]e <Esc>mt?begin<CR>yy`tpwciwend<Esc>A
nnoremap <buffer> ]] mt?begin<CR>yy`tpwciwend<Esc>

inoremap <buffer> <C-c><C-j> <Esc>o* 
inoremap <buffer> <C-c><C-k> <Esc>O* 
nnoremap <buffer> <C-c><C-j> <Esc>o* 
nnoremap <buffer> <C-c><C-k> <Esc>O* 
