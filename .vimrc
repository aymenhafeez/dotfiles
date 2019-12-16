filetype plugin indent on
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set ai
set number
set relativenumber
set ruler
set autochdir
set sb
set spr
set nottimeout

set background=light
highlight Comment ctermfg=DarkGreen
highlight String ctermfg=Yellow
highlight LineNr ctermfg=Yellow

let mapleader="\<Space>"

nmap j gj
nmap k gk

nnoremap <Leader>ls :buffers<CR>:buffer<Space>

" load plaintex files as tex files
augroup filetype_tex
    autocmd!
    autocmd FileType plaintex set filetype=tex
augroup END

" uncomment to load custom functions
" load external config.vim files
" for filename in sort(split(glob('~/.vim/config/*.vim'), '\n'))
"     execute 'source '.filename
" endfor
