set nocompatible	" required 
filetype off 		" required
set number		" required

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" file explorer
Plugin 'scrooloose/nerdtree'
" git status for NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'
" icons for NERDTree
Plugin 'ryanoasis/vim-devicons'

" autopairing parentheses, apostrophes, etc.
Plugin 'jiangmiao/auto-pairs'
" autocomplete 
Plugin 'davidhalter/jedi-vim'
" surround text with parentheses, apostrophes, etc.
Plugin 'tpope/vim-surround'
" shortcut for commenting
Plugin 'scrooloose/nerdcommenter'

" language/file type specific
Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'lervag/vimtex'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-git'

" themes and apperance
Plugin 'lifepillar/vim-solarized8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Rigellute/rigel'
" status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()            " required
filetype plugin indent on    " required

" set <spacebar> as leader
map <Space> <Leader>

" -----------------------------------------------------------------------------
" plugin settings and shortcuts 
" -----------------------------------------------------------------------------

" scrooloose/nerdtree
" .............................................................................
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
let g:NERDTreeDisableFileExtensionHighlight = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
" minimise lag with icons plugin
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0

" add space after comment
let g:NERDSpaceDelims = 1

" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

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

" python-mode/python-mode
" .............................................................................
let python_highlight_all=3
syntax on

let g:pymode_python = 'python3.7'
let g:jedi#force_py_version = 3
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
" let g:pymode_rope_completion = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_options_colorcolumn = 0

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

" -----------------------------------------------------------------------------
" general bindings and shortcuts
" -----------------------------------------------------------------------------

" open .vimrc in new tab
map <Leader>vc :tabnew $MYVIMRC<CR>

" source .vimrc
map <Leader>sv :source $MYVIMRC<CR>

" install plugins
cnoremap pi PluginInstall

" file search
set path+=**
set wildmenu

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

" untab in command mode
nnoremap <S-Tab> <<
" untab in insert mode
inoremap <S-Tab> <C-d>

" easier navigation between split planes
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

" window  positions
nmap <Leader>wh :leftabove vnew<CR>
nmap <Leader>wl :rightbelow vnew<CR>
nmap <Leader>wk :leftabove new<CR>
nmap <Leader>wj :rightbelow new<CR>

nmap <Leader>swh :topleft vnew<CR>
nmap <Leader>swl :botright vnew<CR>
nmap <Leader>swk :topleft new<CR>
nmap <Leader>swj :botright new<CR>

" easier switching between buffers
map gk :bn<cr>
map gj :bp<cr>
map gd :bd<cr>  

" enable folding
set foldmethod=indent
set foldlevel=99

" ------------------------------------------------------------------------------
" theme and appearance
" ------------------------------------------------------------------------------
set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable
set background=dark
colorscheme solarized8_flat
" colorscheme rigel

set encoding=utf8

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
" let g:rigel_airline = 1
" let g:airline_theme = 'rigel'

" background colour of pane split
highlight VertSplit ctermbg=NONE guibg=NONE
highlight CursorLineNR guifg=#2d5761

set relativenumber

