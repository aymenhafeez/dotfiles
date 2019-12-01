" -----------------------------------------------------------------------------
" aymen hafeez vimrc

" zc/zo to open/close a fold
" zR/zM to open/close all folds
" zn to disable folds
" -----------------------------------------------------------------------------

" general configuration {{{
" -----------------------------------------------------------------------------

set nocompatible
set autoread
set modifiable
set encoding=utf8
set ttimeoutlen=0
set lazyredraw
set history=10000
set scrolloff=7
set foldmethod=marker

" set <Space> as leader
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" show relative line numbers
set number
set relativenumber

" only make search case-sensitive if it contains an upper-case character
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
set wildmode=full

" change sp to below and vsp to the right
set splitbelow splitright

" tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" return to last edit position when opening files
augroup last_edit
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" }}}

" plugins {{{
" -----------------------------------------------------------------------------

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
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'

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

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on
" -----------------------------------------------------------------------------

" turn off autocommenting new line for all filetypes
" needs to go after Vundle as Vundle turns filetype off
augroup auto_comment
    autocmd!
    autocmd filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" }}}

" plugin specific settings and mappings {{{
" -----------------------------------------------------------------------------

" ........................... Chiel92/vim-autoformat ..........................
let g:formatter_yapf_style = 'pep8'

" .......................... scrooloose/nerdcommenter .........................
" add space after comment
let g:NERDSpaceDelims=1

" scrooloose/nerdtree
" .............................................................................
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
" Quit out of vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeWinSize=25
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$'] "ignore files in NERDTree

nnoremap <silent> <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" ........................... Valloric/YouCompleteMe ..........................
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ............................. simeji/winresizer .............................
let g:winresizer_vert_resize=5
let g:winresizer_finish_with_escape=1
let g:winresizer_start_key = '<C-t>'

" ...................... christoomey/vim-tmux-navigator .......................
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

" ............................... junegunn/fzf ................................
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>fz :FZF<CR>

" ......................... suan/vim-instant-markdown .........................
let g:instant_markdown_slow=1
let g:instant_markdown_allow_unsafe_content=1
let g:instant_markdown_mathjax=1

nnoremap <Leader>mk :InstantMarkdownPreview<CR> 

" .......................... python-mode/python-mode ..........................
let g:pymode_python='python3'
let g:pymode_rope=0

" ............................ vim-latex/vim-latex ............................
let g:tex_flavor='latex'

" .............................. lervag/vimtex ................................
let g:vimtex_compiler_enabled=0

" .......................... jupyter-vim/jupyter-vim ..........................
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
nnoremap <Leader>co :JupyterConnect<CR>

" change to directory of current file
nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>

" send a selection of lines
nnoremap <buffer> <silent> <localleader>X :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

nnoremap <buffer> <silent> <localleader>U :JupyterUpdateShell<CR>

" ............................... vim/netrw.vim ...............................
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_winsize=45
let g:netrw_preview=1
let g:netrw_alto=0

set autochdir

augroup netrw_mappings
    autocmd!
    autocmd filetype netrw nnoremap <buffer> <C-l> <C-w>l
    autocmd filetype netrw nnoremap <buffer> <Esc> :bd<CR>
augroup END

" open netrw in directory of current file
nnoremap - :e %:p:h<CR>
nnoremap s- :Sexplore %:p:h<CR>
nnoremap v- :Vexplore %:p:h<CR>

" }}}

" mappings {{{
" -----------------------------------------------------------------------------

" move through wrapped lines
nmap j gj
nmap k gk

" slightly faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" easier to jump to first non-whitespace character
nnoremap 0 ^
nnoremap ^ 0

" go to previously used buffer
nnoremap <silent> <Leader><Leader> <C-^>

" open vimrc in new buffer
nnoremap <Leader>vc :e $MYVIMRC<CR>

" open vimrc in vertically split buffer 
nnoremap <Leader>vt :vsp $MYVIMRC<CR>

" source vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>

" source chunkwmrc
nnoremap <Leader>schk :!clear && brew services restart chunkwm<CR>

" source chunkwmrc
nnoremap <Leader>sskd :!clear && brew services restart skhd<CR>

" shortcut to save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" TeX mappings {{{
augroup TeX_mappings
    autocmd!
    autocmd filetype tex,latex,markdown inoremap <buffer> ( ()<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> ) ()<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> [ []<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> ] []<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> { {}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> } {}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> $ $$<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> $$ $$$$<++><Esc>hi
    autocmd filetype tex,latex,markdown inoremap <buffer> \itl \textit{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \bf \textbf{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \eqn \begin{align}<Esc><CR>i\end{align}<Esc>ko
    autocmd filetype tex,latex,markdown inoremap <buffer> \eqa \begin{eqnarray}<Esc><CR>i\end{eqnarray}<Esc>ko
    autocmd filetype tex,latex,markdown inoremap <buffer> \frac \frac{}{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \int \int_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \sum \sum_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \sm \sum_{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \prod \prod_{}^{<++>}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \prd \prod_{}<++><Esc>bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l( \left(\right)<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l[ \left[\right]<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \l{ \left{\right}<++><Esc>3bli
    autocmd filetype tex,latex,markdown inoremap <buffer> \eq[ \[\]<++><Esc>5hi
    autocmd filetype tex,latex,markdown inoremap <buffer> \ra $\rightarrow$
    autocmd filetype tex,latex,markdown inoremap <buffer> \bg \begin{}
    autocmd filetype tex,latex,markdown inoremap <buffer> \bal \begin{align}<CR><CR>\end{align}<Esc>ki<tab>
    autocmd filetype tex,latex,markdown inoremap <buffer> \nbal \begin{align*}<CR><CR>\end{align*}<Esc>ki<tab>
    autocmd filetype tex,latex,markdown inoremap <buffer> \fig \begin{figure}[H]<CR><CR>\end{figure}<Esc>ki\centering<CR>\includegraphics[width=\textwidth]{<++>}<CR>\caption{<++>}<Esc><CR><CR>i<++><Esc>3k3wli
    " move to next placeholder
    autocmd filetype tex,latex,markdown inoremap <buffer> <C-l> <Esc>/<++><CR><Esc>cf>
    " compile and open/update pdf
    autocmd filetype tex,latex nnoremap <buffer> <silent> <Leader>cm :w!<CR>:!clear && pdflatex % && open %:t:r.pdf<CR><CR>
augroup END
" }}}

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
nnoremap <silent> gF :vertical wincmd f<CR>

" open split panes
nnoremap <silent> <Leader>wh :leftabove vnew<CR>
nnoremap <silent> <Leader>wl :rightbelow vnew<CR>
nnoremap <silent> <Leader>wk :leftabove new<CR>
nnoremap <silent> <Leader>wj :rightbelow new<CR>

nnoremap <silent> <Leader>swh :topleft vnew<CR>
nnoremap <silent> <Leader>swl :botright vnew<CR>
nnoremap <silent> <Leader>swk :topleft new<CR>
nnoremap <silent> <Leader>swj :botright new<CR>

" zoom in and out of splits
nnoremap <silent> <Leader>- :wincmd _<CR>:wincmd \|<CR>
nnoremap <silent> <Leader>= <C-w>=

" Emacs-like movement in the command line
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>

" disable arrow keys in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" disable arrow keys in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" laziness
nnoremap <Leader>o :open 
nnoremap <Leader>pi :PluginInstall<CR>

" open/close fold
nnoremap fo zo
nnoremap fc zc

" fold/unfold all
nnoremap <Leader>fa zM
nnoremap <Leader>uf zR

" replace all
nnoremap <Leader>sub :%s///g<left><left><left>
vnoremap <Leader>sub :s///g<left><left><left>

" removes last command showing in cl
nnoremap <Leader><Esc> i<Esc>l

" no idea what Ex mode is
nmap Q  <silent>
nmap K  <silent>

" open a buffer for quick use
nnoremap <Leader>q :e ~/buffer<CR>

" copy file path
nnoremap <silent> yZ :let @" = expand("%:p")<CR>

" open help contents for added plugins
nnoremap <Leader>rh :help local-additions<CR>

" copy filename
nnoremap <silent> yY :let @" = expand("%")<CR>

" .................. spell checking (taken from amix/vimrc) ...................
" toggle and untoggle spell checking
map <Leader>spl :setlocal spell!<CR>

" shortcuts
map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>s? z=

" ......................... misc functional mappings ..........................
nnoremap <Leader>n :call RenameFile()<CR>

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <Leader>spf :call FixLastSpellingError()<CR>

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>

" }}}
    
" theme and appearance {{{
" -----------------------------------------------------------------------------

set termguicolors
syntax enable

" needs to go before the highlight_colours augroup
function! Highlights() abort
    highlight VertSplit guifg=#002b36 guibg=#002b36      
    highlight StatusLineNC guibg=#0f3f4c guifg=#002b36
    highlight CursorLineNR guifg=#38616b guibg=#002b36
    highlight CursorLine guibg=#01313d
    highlight WildMenu guifg=#eff1cc guibg=#002b36
    highlight ErrorMsg guibg=#002b36 guifg=#EC5050
endfunction

augroup highlight_colours
    autocmd!
    autocmd ColorScheme * call Highlights()
augroup END

set background=dark
colorscheme solardust

" vim-airline/vim-airline
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" }}}

" functions {{{
" -----------------------------------------------------------------------------

" rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" easier to use help
function! HelpFileHelp()
  wincmd _ " maximze help on open
  nnoremap <buffer> <tab> :call search('\|.\{-}\|', 'w')<CR>:noh<CR>2l
  nnoremap <buffer> <S-tab> F\|:call search('\|.\{-}\|', 'wb')<CR>:noh<CR>2l
  nnoremap <buffer> <CR> <C-]>
  nnoremap <buffer> <BS> <C-t>
  nnoremap <buffer> q :q<CR>
  setlocal nonumber
endfunction

augroup help_help
    autocmd!
    autocmd filetype help call HelpFileHelp()
augroup END

" insert tab at beginning of line or use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-p>"
    endif
endfunction

" press * or # to search for current visual selection (taken from amix/vimrc)
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" from christoomey's 'vim plugin' talk
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

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

" }}}
