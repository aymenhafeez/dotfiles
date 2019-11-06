" =============================================================================
" aymen hafeez .vimrc
" =============================================================================

set nocompatible 
filetype off
syntax on
set encoding=utf8

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" nerdtree related
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'

" general
Bundle 'Valloric/YouCompleteMe'
Plugin 'simeji/winresizer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mhinz/vim-startify'

" language/file type specific
Plugin 'python-mode/python-mode'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'jaxbot/browserlink.vim'
Plugin 'lervag/vimtex'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-git'
Plugin 'szymonmaszke/vimpyter'
Plugin 'hanschen/vim-ipython-cell'
Plugin 'jpalardy/vim-slime'

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
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Quit out of vim if NERDTree is the only buffer
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeDisableFileExtensionHighlight = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" add space after comment
let g:NERDSpaceDelims = 1

" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Xuyuanp/nerdtree-git-plugin
" .............................................................................
let g:NERDTreeIndicatorMapCustom = {
     \ "Modified"  : "✹",
     \ "Staged"    : "✚",
     \ "Untracked" : "✭",
     \ "Renamed"   : "➜",
     \ "Unmerged"  : "═",
     \ "Deleted"   : "✖",
     \ "Dirty"     : "✗",
     \ "Clean"     : "✔︎",
     \ 'Ignored'   : '☒',
     \ "Unknown"   : "?"
     \ }

" 'Valloric/YouCompleteMe
" .............................................................................
let g:ycm_autoclose_preview_window_after_completion=1
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" simeji/winresizer
" .............................................................................
let g:winresizer_vert_resize=3 
let g:winresizer_finish_with_escape=1

" shortcut to save and run Python files
map <Leader>py <Esc>:w<CR>:!clear;python3 %<CR>

set guioptions=
set modifiable

" suan/vim-instant-markdown" 
" .............................................................................
filetype plugin on
let g:instant_markdown_slow = 1
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_mathjax = 1

" python-mode/python-mode
" .............................................................................
let g:pymode_python = 'python3'
let g:pymode_rope = 0

" xuhdev/vim-latex-live-preview
" .............................................................................
let g:livepreview_previewer = 'Preview'
let g:livepreview_previewer = 'open -a Preview'

" szymonmaszke/vimpyter
" .............................................................................
autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>

" -----------------------------------------------------------------------------
" general config 
" -----------------------------------------------------------------------------

" show relative line numbers
set number
set relativenumber

" file search
set path+=**
set wildmenu

" tabbing
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" -----------------------------------------------------------------------------
" bindings and shortcuts
" -----------------------------------------------------------------------------

" set <spacebar> as leader
map <Space> <Leader>

" open .vimrc in new tab
map <Leader>vc :tabnew $MYVIMRC<CR>

" source .vimrc
map <Leader>sv :source $MYVIMRC<CR>

" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

" easier navigation between split panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" easier navigation between tabs
nnoremap tn :tabnew<Space>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tj :tabfirst<CR>
nnoremap tk :tablast<CR>

" easier navigation between buffers
map bl :bn<cr>
map bh :bp<cr>
map bd :bd<cr>  

" window  positions
nmap <Leader>wh :leftabove vnew<CR>
nmap <Leader>wl :rightbelow vnew<CR>
nmap <Leader>wk :leftabove new<CR>
nmap <Leader>wj :rightbelow new<CR>

nmap <Leader>swh :topleft vnew<CR>
nmap <Leader>swl :botright vnew<CR>
nmap <Leader>swk :topleft new<CR>
nmap <Leader>swj :botright new<CR>

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

map <Leader>pi :PluginInstall

map <Leader>f :find 

" -----------------------------------------------------------------------------
" theme and appearance
" -----------------------------------------------------------------------------

set termguicolors

set background=dark
colorscheme spacedust

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" let g:rigel_airline = 1
" let g:airline_theme = 'rigel'

" background colour of pane split
highlight VertSplit ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#2d5761

