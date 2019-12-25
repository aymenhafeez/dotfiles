" ------------------------------ general settings -----------------------------

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set autoindent
set hidden
set number
set relativenumber
set history=1000
set scrolloff=5
set incsearch
set hlsearch
set ruler
set laststatus=2
set autochdir
set noswapfile
set nobackup
set ttimeoutlen=0

set path=.,,**
set wildmenu
set wildmode=full

set splitbelow
set splitright

let mapleader="\<Space>"

" vim-cool --- show # matches in cmd line
let g:CoolTotalMatches = 1

set background=light
hi LineNr ctermfg=lightyellow

runtime! config/*.vim
