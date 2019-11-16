" =============================================================================
" aymen hafeez .vimrc
" =============================================================================

" -----------------------------------------------------------------------------
" general config 
" -----------------------------------------------------------------------------

filetype off
set autoread
set hidden
syntax enable
set encoding=utf8
set ttimeoutlen=0
set modifiable

" set <spacebar> as leader
nmap <Space> <Leader>

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
" .............................................................................
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle = 3
let g:netrw_winsize = 13

function! ToggleVExplorer() abort
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

nmap <silent> <C-N> :call ToggleVExplorer()<CR>

" change directory to the current buffer when opening files.
set autochdir

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" general
Plugin 'ryanoasis/vim-devicons'
Bundle 'Valloric/YouCompleteMe'
Plugin 'simeji/winresizer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mhinz/vim-startify'
Plugin 'joeytwiddle/sexy_scroller.vim'
Plugin 'vim-scripts/Conque-Shell'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'

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
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'tmux-plugins/vim-tmux'
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

" scrooloose/nerdcommenter
" .............................................................................
" add space after comment
let g:NERDSpaceDelims=1

" 'Valloric/YouCompleteMe
" .............................................................................
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
let g:instant_markdown_slow=1
let g:instant_markdown_allow_unsafe_content=1
let g:instant_markdown_mathjax=1

nnoremap <Leader>m :InstantMarkdownPreview<CR> 

" python-mode/python-mode
" .............................................................................
let g:pymode_python='python3'
let g:pymode_rope=0

" vim-latex/vim-latex
" .............................................................................
let g:tex_flavor='latex'

" xuhdev/vim-latex-live-preview
" .............................................................................
let g:livepreview_previewer='open -a Preview'
nnoremap <silent> <Leader>tx :LLPStartPreview<CR>

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

" vim-airline/vim-airline
" .............................................................................
nnoremap <silent> <Leader>a :AirlineToggle<CR>
let g:airline#extensions#tabline#buffer_min_count=2

" -----------------------------------------------------------------------------
" bindings
" -----------------------------------------------------------------------------

" open .vimrc in new buffer
nnoremap <Leader>vc :e $MYVIMRC<CR>

" open .vimrc in vertically split buffer 
nnoremap <Leader>vt :vsp $MYVIMRC<CR>

" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>

" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

" netrw
nnoremap <Leader>N :edit .<CR>

" shortcut to save and run Python files
nnoremap <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

" TeX mappings
augroup TexMappings
    autocmd!
    autocmd FileType tex,latex,markdown inoremap <buffer> $ $$<Esc>i
    autocmd FileType tex,latex,markdown inoremap <buffer> $$ $$$$<Esc>hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \itl \textit{}<Esc>i
    autocmd FileType tex,latex,markdown inoremap <buffer> \bf \textbf{}<Esc>i
    autocmd FileType tex,latex,markdown inoremap <buffer> \eqn \begin{equation}<Esc><CR>i\end{equation}<Esc>ko
    autocmd FileType tex,latex,markdown inoremap <buffer> \frac \frac{}{}<Esc>2hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \int \int_{}^{}<Esc>3hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \sum \sum_{}^{}<Esc>3hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \sm \sum_{}<Esc>i
    autocmd FileType tex,latex,markdown inoremap <buffer> \prod \prod_{}^{}<Esc>3hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \prd \prod_{}<Esc>i
    autocmd FileType tex,latex,markdown inoremap <buffer> \l( \left(\right)<Esc>6hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \l[ \left[\right]<Esc>6hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \l{ \left{\right}<Esc>6hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \l{ \left{\right}<Esc>6hi
    autocmd FileType tex,latex,markdown inoremap <buffer> \eq[ \[\]<Esc>hi
augroup END

" easier navigation between tabs
nnoremap <silent> tn :tabnew<Space>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> th :tabprev<CR>
nnoremap <silent> tj :tabfirst<CR>
nnoremap <silent> tk :tablast<CR>

" easier navigation between buffers
nnoremap <silent> <Leader>bl :bn<CR>
nnoremap <silent> <Leader>bh :bp<CR>
nnoremap <silent> <Leader>bd :bd<CR>  

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
nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

" disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

nmap <Leader>o :open 

nmap <Leader>pi :PluginInstall<CR>

" removes last command showing in cl
nnoremap <Esc><Esc> i<Esc>l

" hide ui elements
let s:hidden_all=1
function! ToggleHideAll() abort
    if s:hidden_all==0
        let s:hidden_all=1
        " set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all=0
        " set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>

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
map <silent> <Leader>zt :ToggleZoom<CR>

" -----------------------------------------------------------------------------
" theme and appearance
" -----------------------------------------------------------------------------

set termguicolors

set background=dark
colorscheme spacedust
" colorscheme solarized8_flat

" airline statusbar
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" let g:rigel_airline=1
" let g:airline_theme='rigel'

highlight VertSplit ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#38616b
