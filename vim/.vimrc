" aymenhafeez vimrc <aymennh@gmail.com>
" Created:  23/10/2016
" Modified: 12/05/2020
" Version:  VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Mar 15 2020 22:59:24)
" Location: https://github.com/aymenhafeez/dotfiles/tree/master/vim
" =============================================================================

" This file contains general settings and some plugin related settings
" Functions, autocommands, mappings, etc. live in .vim/

syntax on
filetype plugin indent on
set backspace=indent,eol,start

set autochdir
set autoindent
set autoread
set expandtab
set foldmethod=marker
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set matchpairs+=<:>
set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowritebackup
set noshowmode
set path+=**
set ruler
set shiftwidth=4
set showcmd
set smartcase
set tabstop=4
set ttimeoutlen=0
set ttymouse=xterm2

set complete=.,w,b,u,t,i,kspell
set completeopt=menu,longest,menuone
set omnifunc=syntaxcomplete#Complete

set wildcharm=<C-z>
set wildignore=*.pyc
set wildmenu
set wildmode=list:full

set undodir=~/.vim/undo-dir
set undofile

let mapleader="\<Space>"
let maplocalleader="\<Space>"

let g:tex_flavor="latex"

" Plugin settings
" ===============

" vim/netrw.vim
" -------------
let g:netrw_banner=0
let g:netrw_preview = 1
let g:netrw_alto=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 17

" aymenhafeez/scratch.vim
" -----------------------
nnoremap <leader>sc :Scratch<CR>
nnoremap <leader>ss :Sscratch<CR>


" load help files for plugins
packloadall
silent! helptags ALL
