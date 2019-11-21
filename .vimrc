" =============================================================================
" aymen hafeez .vimrc
" =============================================================================

" -----------------------------------------------------------------------------
" general config 
" -----------------------------------------------------------------------------

set autoread
set modifiable
set encoding=utf8
set ttimeoutlen=0
set lazyredraw

" set <spacebar> as leader
nmap <Space> <Leader>

" show relative line numbers
set number
set relativenumber

" search
set incsearch
set ignorecase
set smartcase

" turn off swap files
set noswapfile
set nobackup
set nowb

" autocompletion in commandline
set path+=**
set wildmenu
set wildmode=longest,list,full

" change sp to below and vsp to the right
set splitbelow splitright

" tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------
 filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" general
Bundle 'Valloric/YouCompleteMe'
Plugin 'simeji/winresizer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-vinegar'

" language/file type specific
Plugin 'Chiel92/vim-autoformat'
Plugin 'python-mode/python-mode'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'lervag/vimtex'

call vundle#end()            
filetype plugin indent on

" -----------------------------------------------------------------------------
" plugin settings and shortcuts 
" -----------------------------------------------------------------------------

" scrooloose/nerdcommenter
" .............................................................................
" add space after comment
let g:NERDSpaceDelims=1

" 'Valloric/YouCompleteMe
" .............................................................................
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" simeji/winresizer
" .............................................................................
let g:winresizer_vert_resize=3 
let g:winresizer_finish_with_escape=1

" christoomey/vim-tmux-navigator
" .............................................................................
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

" junegunn/fzf
" .............................................................................
set rtp+=/usr/local/opt/fzf
nmap <Leader>fz :FZF<CR>

" suan/vim-instant-markdown" 
" .............................................................................
filetype plugin on
let g:instant_markdown_slow=1
let g:instant_markdown_allow_unsafe_content=1
let g:instant_markdown_mathjax=1

nnoremap <Leader>mk :InstantMarkdownPreview<CR> 

" python-mode/python-mode
" .............................................................................
let g:pymode_python='python3'
let g:pymode_rope=0

" vim-latex/vim-latex
" .............................................................................
let g:tex_flavor='latex'

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
nmap <Leader>co :JupyterConnect<CR>

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

" -----------------------------------------------------------------------------
" bindings
" -----------------------------------------------------------------------------

" move through wrapped lines
nmap j gj
nmap k gk

" go to previously used buffer
nnoremap <silent> <Space><Space> :b#<CR>

" open netrw in directory of current file
" nnoremap - :e %:p:h<CR>

" open .vimrc in new buffer
nnoremap <Leader>vc :e $MYVIMRC<CR>

" open .vimrc in vertically split buffer 
nnoremap <Leader>vt :vsp $MYVIMRC<CR>

" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>

" source chunkwmrc
nnoremap <Leader>schk :!clear && brew services restart chunkwm<CR>

" source chunkwmrc
nnoremap <Leader>sskd :!clear && brew services restart skhd<CR>

" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

" shortcut to save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" TeX mappings
augroup TexMappings
    autocmd!
    autocmd FileType tex,latex,markdown inoremap <buffer> ( ()<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> [ []<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> { {}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> $ $$<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> $$ $$$$<++><Esc>hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \itl \textit{}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \bf \textbf{}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \eqn \begin{equation}<Esc><CR>i\end{equation}<Esc>ko
    autocmd FileType tex,latex,markdown inoremap <buffer> \frac \frac{}{<++>}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \int \int_{}^{<++>}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \sum \sum_{}^{<++>}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \sm \sum_{}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \prod \prod_{}^{<++>}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \prd \prod_{}<++><Esc>bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \l( \left(\right)<++><Esc>3bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \l[ \left[\right]<++><Esc>3bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd FileType tex,latex,markdown inoremap <buffer> \eq[ \[\]<++><Esc>5hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \bg \begin{}

    autocmd FileType tex,latex,markdown inoremap <buffer> <Space><Space> <Esc>/<++><CR><Esc>cf>
    autocmd FileType tex,latex nnoremap <buffer> :w<CR> :w!<CR>:!clear && pdflatex % && open %:t:r.pdf<CR><CR>
augroup END

" easier navigation between tabs
nnoremap tn :tabnew<Space>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> th :tabprev<CR>
nnoremap <silent> tj :tabfirst<CR>
nnoremap <silent> tk :tablast<CR>

" easier navigation between buffers
nnoremap <silent> <Leader>bl :bn<CR>
nnoremap <silent> <Leader>bh :bp<CR>
nnoremap <silent> <Leader>bd :bd<CR>  
nnoremap <Leader>ls :buffers<CR>:buffer<Space>

" open split panes
nmap <silent> <Leader>wh :leftabove vnew<CR>
nmap <silent> <Leader>wl :rightbelow vnew<CR>
nmap <silent> <Leader>wk :leftabove new<CR>
nmap <silent> <Leader>wj :rightbelow new<CR>

nmap <silent> <Leader>swh :topleft vnew<CR>
nmap <silent> <Leader>swl :botright vnew<CR>
nmap <silent> <Leader>swk :topleft new<CR>
nmap <silent> <Leader>swj :botright new<CR>

" Emacs-like movement in the command line
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>

nmap <Leader>o :open 

nmap <Leader>pi :PluginInstall<CR>

" replace all
nnoremap S :%s//g<Left><Left>

" removes last command showing in cl
nnoremap <Leader><Esc> i<Esc>l

" ignoring things I accidentally type sometimes
nmap Q  <silent>
nmap q: <silent>
nmap K  <silent>

" zoom a single window in splits 
function! s:ToggleZoom() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

command! ToggleZoom call s:ToggleZoom()
nmap <silent> tz :ToggleZoom<CR>

" hide ui elements
let s:hidden_all=0
function! ToggleHideAll() abort
    if s:hidden_all==0
        let s:hidden_all=1
        set showmode
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
syntax enable

function! Highlights() abort
    highlight VertSplit guifg=#002b36 guibg=#002b36      
    highlight StatusLineNC guibg=#0f3f4c guifg=#002b36
    highlight CursorLineNR guifg=#38616b guibg=#002b36
endfunction
    
augroup Colors
    autocmd!
    autocmd ColorScheme * call Highlights()
augroup END

set background=dark
colorscheme solardust

" statusbar
set statusline=%#StatusLineNC#%<%h%m%r%=%-14.(%l,%c%V%)\ %P
set rulerformat=%30(%#StatusLineNC#%<%h%m%r%=%-14.(%l,%c%V%)\ %P%*%)
set fillchars=fold:_,stl:_,stlnc:_,vert:│
