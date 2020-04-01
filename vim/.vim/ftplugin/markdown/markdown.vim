" Settings and mappings for Markdown
" ----------------------------------

set tabstop=4
set shiftwidth=4
set expandtab
set tw=80
set fo+=t
setlocal spell!
set conceallevel=1

nnoremap <buffer> <Leader>mk :InstantMarkdownPreview<CR>

" close environments
inoremap <buffer> ]] <Esc>?begin<CR>yypwciwend<Esc>O
inoremap <buffer> ]e <Esc>mt?begin<CR>yy`tpwciwend<Esc>A
nnoremap <buffer> ]] mt?begin<CR>yy`tpwciwend<Esc>
