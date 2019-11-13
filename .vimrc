" =============================================================================
" aymen hafeez .vimrc
" =============================================================================

" -----------------------------------------------------------------------------
" general config 
" -----------------------------------------------------------------------------

set nocompatible 
filetype off
set autoread
set hidden
syntax enable
set encoding=utf8
set ttimeoutlen=0
set modifiable

" set <spacebar> as leader
map <Space> <Leader>

" show relative line numbers
set number
set relativenumber

" turn off swap files
set noswapfile
set nobackup
set nowb

" name completion and suggestion with :find command
set path+=**
set wildmenu

" tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" netrw config
let g:netrw_banner=0
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" nerdtree related
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-fugitive'

" general
Bundle 'Valloric/YouCompleteMe'
Plugin 'simeji/winresizer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'mhinz/vim-startify'
Plugin 'joeytwiddle/sexy_scroller.vim'
Plugin 'vim-scripts/Conque-Shell'
Plugin 'christoomey/vim-tmux-navigator'

" language/file type specific
Plugin 'python-mode/python-mode'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'jaxbot/browserlink.vim'
Plugin 'lervag/vimtex'
Plugin 'vim-latex/vim-latex'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-git'
Plugin 'jpalardy/vim-slime'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'ivanov/vim-ipython'

" themes, apperance and status bar
Plugin 'lifepillar/vim-solarized8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Rigellute/rigel'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()            
filetype plugin indent on

" -----------------------------------------------------------------------------
" plugin settings and shortcuts 
" -----------------------------------------------------------------------------

" scrooloose/nerdtree
" .............................................................................
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
" Quit out of vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeWinSize=23
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$'] "ignore files in NERDTree

map <silent> <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" scrooloose/nerdcommenter
" .............................................................................
" add space after comment
let g:NERDSpaceDelims=1

" 'Valloric/YouCompleteMe
" .............................................................................
let g:ycm_autoclose_preview_window_after_completion=1
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" joeytwiddle/sexy_scroller.vim
" .............................................................................
let g:SexyScroller_EasingStyle=3
let g:SexyScroller_ScrollTime=10

" simeji/winresizer
" .............................................................................
let g:winresizer_vert_resize=3 
let g:winresizer_finish_with_escape=1

" christoomey/vim-tmux-navigator
" .............................................................................
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
nnoremap <silent> <C-L> :TmuxNavigateRight<CR>

" suan/vim-instant-markdown" 
" .............................................................................
filetype plugin on
" let g:instant_markdown_slow=1
let g:instant_markdown_allow_unsafe_content=1
let g:instant_markdown_mathjax=1

map <Leader>m :InstantMarkdownPreview<CR> 

" python-mode/python-mode
" .............................................................................
let g:pymode_python='python3'
let g:pymode_rope=0

" jupyter-vim/jupyter-vim
" .............................................................................
" mostly from jupyter-vim/jupyter-vim README
if has('nvim')
    let g:python3_host_prog='/usr/local/bin/python3.7'
else
    set pyxversion=3

    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/Python
endif

" run current file
nnoremap <buffer> <silent> <localleader>R :w<CR>:JupyterRunFile<CR>
nnoremap <buffer> <silent> <localleader>I :JupyterImportThisFile<CR>
map <Leader>co :JupyterConnect<CR>

" change to directory of current file
nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>

" send a selection of lines
nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

nnoremap <buffer> <silent> <localleader>U :JupyterUpdateShell<CR>

" debugging maps
nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>

" xuhdev/vim-latex-live-preview
" .............................................................................
let g:livepreview_previewer='Preview'
let g:livepreview_previewer='open -a Preview'

" vim-airline/vim-airline
" .............................................................................
map <silent> <Leader>a :AirlineToggle<CR>
let g:airline#extensions#tabline#buffer_min_count=2

" -----------------------------------------------------------------------------
" bindings
" -----------------------------------------------------------------------------

" open .vimrc in new buffer
map <Leader>vc :e $MYVIMRC<CR>

" open .vimrc in vertically split buffer 
map <Leader>vt :vsp $MYVIMRC<CR>

" source .vimrc
map <Leader>sv :source $MYVIMRC<CR>

" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

" netrw
map <Leader>N :edit .<CR>

" shortcut to save and run Python files
map <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" auto pair for LaTeX equations
autocmd FileType tex inoremap <buffer> $ $$<Esc>i
autocmd FileType tex inoremap <buffer> $$ $$$$<Esc>hi
autocmd FileType markdown inoremap <buffer> $ $$<Esc>i
autocmd FileType markdown inoremap <buffer> $$ $$$$<Esc>hi

" easier navigation between tabs
nnoremap <silent> tn :tabnew<Space>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> th :tabprev<CR>
nnoremap <silent> tj :tabfirst<CR>
nnoremap <silent> tk :tablast<CR>

" easier navigation between buffers
map <silent> bl :bn<CR>
map <silent> bh :bp<CR>
map <silent> bd :bd<CR>  

" open split panes
nmap <silent> <Leader>wh :leftabove vnew<CR>
nmap <silent> <Leader>wl :rightbelow vnew<CR>
nmap <silent> <Leader>wk :leftabove new<CR>
nmap <silent> <Leader>wj :rightbelow new<CR>

nmap <silent> <Leader>swh :topleft vnew<CR>
nmap <silent> <Leader>swl :botright vnew<CR>
nmap <silent> <Leader>swk :topleft new<CR>
nmap <silent> <Leader>swj :botright new<CR>

" disable arrow keys in normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <Leader>o :open 

map <Leader>pi :PluginInstall<CR>

map <Leader>f :find 

nnoremap <Esc><Esc> :<CR>

let s:hidden_all=0
function! ToggleHideAll()
    if s:hidden_all==0
        let s:hidden_all=1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all=0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>

" -----------------------------------------------------------------------------
" theme and appearance
" -----------------------------------------------------------------------------

set termguicolors

set background=dark
colorscheme spacedust

" airline statusbar
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" let g:rigel_airline=1
" let g:airline_theme='rigel'

" background colour of pane split
highlight VertSplit ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#38616b
