" ---------------------------- aymen hafeez vimrc -----------------------------


" --------------------------- general configuration ---------------------------

" {{{
set autoread
set modifiable
set encoding=utf8
set ttimeoutlen=0
set lazyredraw
set laststatus=0

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
set wildmode=full

" change sp to below and vsp to the right
set splitbelow splitright

" tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" cursor stays 7 lines from top and bottom of page when scrolling
set scrolloff=7

" change cursor shape depending on mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" return to last edit position when opening files
augroup last_edit
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" marker folding in .vim files
augroup filetype_vim
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
augroup END
" }}}

" --------------------------------- plugins ----------------------------------

" {{{
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

" ------------------- plugin specific settings and mappings -------------------

" {{{
" ........................... Chiel92/vim-autoformat ..........................
let g:formatter_yapf_style = 'pep8'

" .......................... scrooloose/nerdcommenter .........................
" add space after comment
let g:NERDSpaceDelims=1

" ........................... Valloric/YouCompleteMe ..........................
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ............................. simeji/winresizer .............................
let g:winresizer_vert_resize=3 
let g:winresizer_finish_with_escape=1
let g:winresizer_start_key = '<C-t>'

" ....................... christoomey/vim-tmux-navigator ......................
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>

" ................................ junegunn/fzf ...............................
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

" ........................... vim-latex/vim-latex .............................
let g:tex_flavor='latex'

" ............................... lervag/vimtex ...............................
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
nmap <Leader>co :JupyterConnect<CR>

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

" ---------------------------------- mappings ---------------------------------

" {{{
" move through wrapped lines
nmap j gj
nmap k gk

" laziness
nnoremap <Leader>ww :w!<CR>

" easier to move to start of non-whitespace
nnoremap 0 ^
nnoremap ^ 0

" go to previously used buffer
nnoremap <silent> <Space><Space> :b#<CR>

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

" slightly faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

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

nmap <Leader>o :open 

nmap <Leader>pi :PluginInstall<CR>

" replace all
nnoremap S :%s//g<Left><Left>

" removes last command showing in cl
nnoremap <Leader><Esc> i<Esc>l

" ignoring things I accidentally type sometimes
nmap q: <silent>
nmap K  <silent>

" no idea what Ex mode is
nmap Q  <silent>

" open a buffer for quick use
nnoremap <Leader>q :e ~/buffer<cr>

" open a python buffer for quick use
nnoremap <Leader>q :e ~/buffer<cr>

" copy file path
nnoremap <silent> yZ :let @" = expand("%:p")<CR>

" copy filename
nmap <silent> yY :let @" = expand("%")<CR>

" .................. spell checking (taken from amix/vimrc) ...................
" toggle and untoggle spell checking
map <Leader>spl :setlocal spell!<cr>

" shortcuts
map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>s? z=

" ......................... misc functional mappings ..........................
nnoremap <silent> tz :call ToggleZoom()<CR>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>
" }}}
    
" ----------------------------- theme and appearance -----------------------------

" {{{
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

" statusbar
set statusline=
set statusline+=%#StatusLineNC#%f
set statusline+=%=
set statusline+=%#StatusLineNC#%=%(%l:%c%V%)\ %p
set rulerformat=%30(%#StatusLineNC#%=%(%l:%c%V%)\ %p%*%)
set fillchars=fold:_,stl:_,stlnc:_,vert:│
" }}}

" --------------------------------- functions ---------------------------------

" {{{
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

" zoom a single window in splits 
function! ToggleZoom() abort
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
