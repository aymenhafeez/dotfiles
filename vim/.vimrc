" aymenhafeez vimrc
" Created:  23/10/2017
" Modified: 10/05/2021
" Version:  VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Apr 29 2021 00:26:58)
" Location: https://github.com/aymenhafeez/dotfiles/tree/master/vim
" =============================================================================

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
set noshowmode
set conceallevel=2
set laststatus=2
set cursorline
set number

set hlsearch
set ignorecase
set incsearch
set smartcase

set ruler
set showcmd

set nobackup
set noswapfile
set nowritebackup

set complete+=d
set completeopt=menu,longest,menuone
set omnifunc=syntaxcomplete#Complete

set autochdir
set wildcharm=<C-z>
set wildignore=*.pyc
set wildmenu
set wildmode=full

set autoread
set hidden
set history=1000
set ttimeoutlen=0
set lazyredraw
set matchpairs+=<:>
set mouse=a
set path+=.,**
set ttymouse=xterm2

set undodir=~/.vim/undo-dir
set undofile

let mapleader="\<Space>"
let maplocalleader="\<Space>"

let g:tex_flavor="latex"

" Mappings:

" use j and k to actually move line wise
nnoremap j gj
nnoremap k gk

" slightly easier split navigation
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" navigate through quickfixes
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

" toggle spell check
nnoremap <leader>spl :setlocal spell!<CR>

" replace every instance of the word under the cursor
nnoremap <leader>rg yiW:%s/<C-r>"//g<left><left>
" replace the word under the cursor with confirmation after each instance
nnoremap <leader>rc yiW:%s/<C-r>"//c<left><left>

nnoremap <leader>b :Buffers<CR>
" nnoremap <leader>b :Clap buffers<CR>

" source current file
nnoremap <leader>so :source %<CR>
" source visual selection
vnoremap <leader>so "ay:<C-r>a<Backspace><CR>

" remove trailing whitespace (from the vimwiki)
nnoremap <silent> <leader>wh :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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
nnoremap <leader>sf :call fixspelling#spelling()<CR>
" nnoremap <leader>hg :call highlightgroups#synstack()<CR>
nnoremap <leader>hg :call SyntaxAttr()<CR>
nnoremap <leader>hh :call sendhelp#help()<CR>
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
    " automatically open when a quickfix command is executed and there are valid errors
    autocmd QuickFixCmdPost [^l]* cwindow
augroup END

" Appearance:

augroup CallHighlightGroups
    autocmd!
    autocmd ColorScheme * call highlightgroups#termcolors()
augroup END

set termguicolors
colorscheme onedark
set background=dark

" true colors
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" set statusline=%{statusline#statusline()}

let g:lightline = {
	\ 'colorscheme': 'one',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
    \             [ ],
	\             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ],
    \   'right': [ [ 'percentwin', 'cocstatus'], 
    \               [ 'lineinfo' ],
    \             [ 'filetype', ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
    \   'readonly': 'LightlineReadonly',
    \   'space': ' ',
    \   'gitbranch': 'FugitiveHead'
	\ },
	\ }

function! LightlineReadonly()
    return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! Spaceing()
    echo('  ')
endfunction

" Plugin Settings:

" voldikss/vim-floaterm
nnoremap <silent> <leader>tt :FloatermToggle<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <leader>kf :FloatermKill<CR>

let g:floaterm_wintype='split'
let g:floaterm_height=9
let g:floaterm_position='rightbelow'

" liuchengxu/vim-clap
" -------------------
hi link ClapInput Normal
hi link ClapDisplay Normal
hi link ClapPreview Normal

let g:clap_layout = { 'relative': 'editor' }
" let g:clap_theme = 'nord'

" vim/netrw.vim
" -------------
let g:netrw_banner=0
let g:netrw_alto=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 23
let g:netrw_special_syntax=1

" nnoremap <silent> - :Explore<CR>
" nnoremap <silent> <leader>- :Lexplore<CR>
" nnoremap <silent> s- :Sexplore<CR>
" nnoremap <silent> v- :Vexplore<CR>

" preservevim/NERDTree
nnoremap <silent> <leader>- :NERDTreeToggle<CR>
" let g:NERDTreeStatusline = '%#NonText#'
let NERDTreeDirArrowExpandable = ""
let NERDTreeDirArrowCollapsible = ""
let NERDTreeWinSize = 26
let NERDTreeMinimalUI=1

" aymenhafeez/scratch.vim
" -----------------------
nnoremap <leader>sc :Scratch<CR>
nnoremap <leader>ss :Sscratch<CR>

" sirver/ultisnips
" ----------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" junegunn/fzf.vim
" ----------------
set rtp+=~/.fzf

nnoremap <leader>f :FZF<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" let g:fzf_layout = { 'down': '~19%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4, 'relative': v:true, 'yoffset': 1.0 } }

" load matchit.vim (builtin, needs enabling)
runtime macros/matchit.vim

" " load help files for plugins
" packloadall
" silent! helptags ALL
