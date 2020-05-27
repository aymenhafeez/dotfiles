" aymenhafeez vimrc
" Created:  23/10/2016
" Modified: 12/05/2020
" Version:  VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Mar 15 2020 22:59:24)
" Location: https://github.com/aymenhafeez/dotfiles/tree/master/vim
" =============================================================================

" This file contains general settings, mappings and some plugin related settings
" Autoload functions, filetype settings and plugins, etc. live in .vim/

" General Settings:

syntax on

filetype plugin indent on
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4

set hlsearch
set ignorecase
set incsearch
set smartcase

set ruler
set showcmd

set nobackup
set noswapfile
set nowritebackup

set completeopt=menu,longest,menuone,popup
set omnifunc=syntaxcomplete#Complete

set autochdir
set wildcharm=<C-z>
set wildignore=*.pyc
set wildmenu
set wildmode=full

set autoread
set hidden
set history=1000
set lazyredraw
set matchpairs+=<:>
set mouse=a
set path+=.,**
set ttimeoutlen=0
set ttymouse=xterm2

set undodir=~/.vim/undo-dir
set undofile

let mapleader="\<Space>"
let maplocalleader="\<Space>"

let g:tex_flavor="latex"

" Mappings:
" ========

nnoremap <silent> <esc><esc> :nohls<CR>

nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <leader>spl :setlocal spell!<CR>

" netrw
nnoremap <silent> - :Explore<CR>
nnoremap <silent> <leader>- :Lexplore<CR>
nnoremap <silent> s- :Sexplore<CR>
nnoremap <silent> v- :Vexplore<CR>
nnoremap <leader>no :Explore ~/Documents/notes/MyNotes/<CR>

nnoremap <leader>e :FZF<CR>
" nnoremap <leader>f :find <C-d>
nnoremap <leader>f :FZF<CR>

nnoremap <leader>b :buffers<CR>:buffer 

" source current file
nnoremap <leader>so :source %<CR>
" Source visual selection
xnoremap <leader>so :<C-u>@*<CR>

" Remove trailing whitespace (from the vimwiki)
nnoremap <silent> <leader>wh :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Fix previous spelling error from insert mode
inoremap <C-s> <C-g>u<Esc>[s1z=`]a<C-g>u

" Break undo sequence on Space, Tab and Enter
inoremap <Space> <Space><C-g>u
inoremap <Tab> <Tab><C-g>u
inoremap <CR> <CR><C-g>u

" Commnand-line editing (from :h Command-line-editing)
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Search for key words in notes and open .tex file (borrowed from connermcd's config)
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/notes/MyNotes/**/*.{tex,md} | copen
nnoremap <leader>[ :Ngrep 
" na
nnoremap <C-c>n :lnext<CR>
nnoremap <C-c>p :lprev<CR>

" List installed plugins
command! PackList echo system('ls ~/.vim/pack/plugins/start/')

" Determine highlight group of text under the cursor
function! <SID>SynStack()
    if !exists("*synstack")
        return
        endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <leader>hg :call <SID>SynStack()<CR>

" Call autoload function
nnoremap <leader>rn :call renamefile#rename()<CR>
nnoremap <leader>sf :call fixspelling#spelling()<CR>
nnoremap <leader>sh :call screenshot#screenshot()<CR>
command! -nargs=+ -complete=command TabMessage call echooutput#tabmessage(<q-args>)
command! -nargs=0 Pandoc call pandoc#md_to_pdf()
command! -nargs=0 RenamePandoc call pandoc#md_to_pdf_new_name() 

" Autocommands:

" return to last edit position when opening files
augroup last_edit_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" turn off autocommenting new line for all filetypes
augroup auto_comment_off
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Appearance:

set background=dark

highlight clear spellbad
highlight spellbad     ctermbg=none ctermfg=222
highlight conceal      ctermbg=none
highlight signcolumn   ctermbg=235
highlight statusline   ctermbg=250   ctermfg=232 cterm=none
highlight statuslinenc ctermbg=239  ctermfg=250 cterm=none
highlight vertsplit    ctermbg=none ctermfg=250 cterm=none

if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=b
    colorscheme zenburn
endif

" let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" Plugin Settings:

" vim/netrw.vim
" -------------
let g:netrw_banner=0
let g:netrw_alto=0
let g:netrw_liststyle = 3
let g:netrw_winsize = 17

" aymenhafeez/scratch.vim
" -----------------------
nnoremap <leader>sc :Scratch<CR>
nnoremap <leader>ss :Sscratch<CR>

" dense-analysis/ale
" ------------------
nnoremap <leader>ad :ALEDisable<CR>
nnoremap <leader>ae :ALEEnable<CR>

" sirver/ultisnips
" ----------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" junegunn/fzf.vim 
" ----------------
set rtp+=~/.fzf

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~25%' }

runtime macros/matchit.vim

" load help files for plugins
packloadall
silent! helptags ALL
