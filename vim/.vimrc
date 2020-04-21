" aymenhafeez vimrc <aymennh@gmail.com>
" Created:  23/10/2016
" Modified: 21/04/2020
" Version:  VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Mar 15 2020 22:59:24)
" Location: https://github.com/aymenhafeez/dotfiles/
" =============================================================================

" This file contains base settings and plugin related settings.
" Functions, mappings, augroups, etc. live in .vim/plugin/

" general settings
" ================
filetype plugin indent on
syntax on

set backspace=indent,eol,start
set nocompatible
set autoindent
set autoread
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set number
set relativenumber
set showcmd
set noshowmode
set laststatus=2
set history=1000
set incsearch
set hlsearch
set ignorecase
set smartcase
set ruler
set noswapfile
set nobackup
set nowritebackup
set ttimeoutlen=0
set wildcharm=<C-z>
set lazyredraw
set foldmethod=marker
set matchpairs+=<:>
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t,i,kspell
set completeopt=menu,longest,menuone,popup

set ttymouse=xterm2
set mouse=a

set path+=**
set wildmenu
set wildmode=list:full
set wildignore=*.pyc
set autochdir

" set splitbelow
set splitright

" create undodir if it doesn't exist
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif

set undodir=~/.vim/undo-dir
set undofile

let mapleader="\<Space>"
let maplocalleader="\<Space>"

let g:tex_flavor="latex"

"  plugin settings
" ================

" junegunn/fzf.vim 
" ----------------
set rtp+=~/.fzf

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~25%' }


" SirVer/ultisnips
" ----------------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" vim/netrw.vim
" -------------
let g:netrw_banner=0
let g:netrw_preview = 1
let g:netrw_alto=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 17

" jpalardy/vim-slime
" ------------------
let g:slime_target = "tmux"

" dense-analysis/ale
" ------------------
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

" load help files for plugins
packloadall
silent! helptags ALL
