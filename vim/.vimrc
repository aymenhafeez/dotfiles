" aymenhafeez vimrc
" Created:  23/10/2017
" Modified: 10/05/2021
" Version:  VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Apr 29 2021 00:26:58)
" Location: https://github.com/aymenhafeez/dotfiles/tree/master/vim
" =============================================================================

if &compatible
    set nocompatible
endif

" This file contains general settings, mappings and some plugin related settings
" Autoload functions, filetype settings and plugins, etc. live in .vim/

" General Settings:

syntax on
set backspace=indent,eol,start

filetype plugin indent on
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4

set conceallevel=2
set linebreak

set hlsearch
set ignorecase
set incsearch
set smartcase

set nobackup
set noswapfile
set nowritebackup

set completeopt=menu,longest,menuone,popup
set omnifunc=syntaxcomplete#Complete

set autochdir
set wildcharm=<C-z>
set wildignore=*.pyc
set wildmenu
set wildoptions=pum

set autoread
set hidden
set history=250
set ttimeoutlen=0
set lazyredraw
set matchpairs+=<:>
set mouse=a
set path+=.,**

set undodir=~/.vim/undo-dir
set undofile

let mapleader="\<Space>"
let maplocalleader="\<Space>"

let g:tex_flavor="latex"

" Mappings:

nnoremap j gj
nnoremap k gk

" load helptags for plugins
nnoremap <leader>ht :packloadall<CR>:helptags ALL<CR>

" slightly easier split navigation
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprev<CR>

" toggle spell check
nnoremap <leader>spl :setlocal spell!<CR>

nnoremap <leader>b :buffer <C-z><C-p>

" source current file
nnoremap <leader>so :source %<CR>
" source visual selection
vnoremap <leader>so "ay:<C-r>a<Backspace><CR>

" fix previous spelling error from insert mode
inoremap <C-s> <C-g>u<Esc>[s1z=`]a<C-g>u

" break undo sequence on Space, Tab and Enter
inoremap <Space> <Space><C-g>u
inoremap <Tab> <Tab><C-g>u
inoremap <CR> <CR><C-g>u

" commnand-line editing (from :h Command-line-editing)
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" search for key words in notes and open .tex or .md file
command! -nargs=1 Search vimgrep "<args>" ~/Dropbox/notes/MyNotes/**/*.{tex,md}
nnoremap <leader>[ :Search 

" call autoload functions
nnoremap <C-s> :call fixspelling#spelling()<CR>
nnoremap <leader>hg :call SyntaxAttr()<CR>
command! -nargs=0 Pandoc call pandoc#md_to_pdf()
command! -nargs=0 PandocRenamePDF call pandoc#md_to_pdf_new_name()
command! -nargs=0 PandocPDFPreview call pandoc#pdf_preview()


" Autocommands:

augroup MiscAutocommands
    autocmd!
    " return to last edit position when opening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " remove automatically adding comment on new line
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	" autocmd CursorHold * silent call CocActionAsync('highlight')
    " autocmd bufenter * call statusline#lightlineconfig()
    " automatically open when a quickfix command is executed and there are valid errors
    autocmd QuickFixCmdPost [^l]* cwindow
	" mappings for quickfix location list
	autocmd BufReadPost quickfix nnoremap <buffer> <leader>cn :cnext<CR>
	autocmd BufReadPost quickfix nnoremap <buffer> <leader>cp :cprev<CR>
	autocmd BufReadPost quickfix nnoremap <buffer> <leader>ln :lnext<CR>
	autocmd BufReadPost quickfix nnoremap <buffer> <leader>lp :lprev<CR>
augroup END

" Appearance:

augroup CallHighlightGroups
    autocmd!
    autocmd ColorScheme * call highlightgroups#termcolors()
augroup END

" set termguicolors
" colorscheme onedark

" true colors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

let g:floaterm_wintype='split'
let g:floaterm_height=9
let g:floaterm_position='rightbelow'

" vim/netrw.vim
" -------------
let g:netrw_banner=0
let g:netrw_alto=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 15
let g:netrw_special_syntax=1

nnoremap <silent> <leader>- :Lexplore<CR>

" load matchit.vim (builtin, needs enabling)
runtime macros/matchit.vim
