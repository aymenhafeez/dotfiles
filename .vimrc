set nocompatible	" required 
filetype off 		" required
set number		" required

" let Vundle manage Vundle, required
"==============================================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" file explorer
Plugin 'scrooloose/nerdtree'
" live markdown preview
Plugin 'shime/vim-livedown'
" LaTeX preview
Plugin 'lervag/vimtex'
" autocomplete 
Plugin 'davidhalter/jedi-vim'
" solarized theme
Plugin 'lifepillar/vim-solarized8'
Plugin 'altercation/vim-colors-solarized'
" status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Python highlightin, linting, etc.
Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" autopairing parentheses and apostrophes
Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree config
"==============================================================================
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Quit out of vim if NERDTree is the only buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"key bindings
"==============================================================================
" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" navigating tabs:
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" resize windows
" nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" enable folding with the spacebar
nnoremap <space> za

" live markdown preview
nmap gm :LivedownToggle<CR>

" open NERDTree
map <C-n> :NERDTreeToggle<CR>

" easier switching between buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>  

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" easier to run Python files
cnoremap !py !python3<Space>

" shortcut to run save and run Python files
map pyr <Esc>:w<CR>:!clear;python3 %<CR>

" easier to install plugins
cnoremap pi PluginInstall

" enable folding
set foldmethod=indent
set foldlevel=99

" rendering TeX for InstantMarkdown
let g:instant_markdown_mathjax = 1

" Python config
"==============================================================================
" Syntax highlighting for Python
let python_highlight_all=3
syntax on

let g:pymode_python = 'python3.7'
let g:jedi#force_py_version = 3
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
" let g:pymode_rope_completion = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_options_colorcolumn = 0

set guioptions=

set modifiable

" appearance
"==============================================================================
set termguicolors

syntax enable
set background=dark
colorscheme solarized8_flat

" Override color scheme to make split the same color as tmux's default
" autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Set split separator to Unicode box drawing character
set encoding=utf8
" set fillchars=vert:│

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'

" background colour of pane split
highlight VertSplit ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#2d5761

set relativenumber
