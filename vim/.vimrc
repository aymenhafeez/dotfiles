" ------------------------------ general settings -----------------------------

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set autoindent
set expandtab
set hidden
set number
set showcmd
set noshowmode
set relativenumber
set laststatus=2
set history=1000
set scrolloff=5
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

set path+=**
set wildmenu
set wildmode=list:full
set wildignore=*.pyc
set autochdir

set splitbelow
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

let g:tex_flavour="latex"

runtime! config/*.vim
