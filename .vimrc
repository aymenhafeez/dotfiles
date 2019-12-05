" -----------------------------------------------------------------------------
" aymen hafeez vimrc

" zc/zo to open/close a fold
" zR/zM to open/close all folds
" zn to disable folds
" -----------------------------------------------------------------------------

" general configuration {{{
" -----------------------------------------------------------------------------

" so vim doesn't behave like vi (don't know if this is still required in Vim 8)
set nocompatible
" automatically read a file in Vim when it has been changed outside of Vim
set autoread
set encoding=utf8
" escape to normal mode delay
set ttimeoutlen=0
" avoid redrawing the screen when not required
set lazyredraw
" extending command history
set history=10000
" scroll lines above and below the cursor
set scrolloff=7
" folding with markers ({{{ and }}})
set foldmethod=marker
" only show status bar with multiple splits
set laststatus=1
" show column, row and percentage in cmd line
set ruler

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
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'

" language/file type specific
Plugin 'dense-analysis/ale'
Plugin 'python-mode/python-mode'
Plugin 'jupyter-vim/jupyter-vim'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
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

" plugin specific settings and mappings {{{
" -----------------------------------------------------------------------------

" ........................... Valloric/YouCompleteMe ..........................
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
nnoremap <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
vnoremap <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

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
    autocmd filetype netrw nnoremap <silent> <buffer> <Esc> :bd<CR>
augroup END

" open netrw in directory of current file
nnoremap - :Explore %:p:h<CR>
nnoremap s- :Sexplore %:p:h<CR>
nnoremap v- :Vexplore %:p:h<CR>

" }}}

" mappings {{{
" -----------------------------------------------------------------------------

" move through wrapped lines
nnoremap j gj
nnoremap k gk
noremap gj j
noremap gk k

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

" edit/source zshrc
nnoremap <Leader>zc :e ~/Documents/work-env/.zshrc<CR>
nnoremap <Leader>szc :!source ~/.zshrc<CR><CR>

" edit/source chunkwmrc
nnoremap <Leader>chk :e ~/Documents/work-env/.chunkwmrc<CR>
nnoremap <Leader>schk :!clear && brew services restart chunkwm<CR>

" edit/source skhdrc
nnoremap <Leader>skd :e ~/Documents/work-env/.skhdrc<CR>
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
    autocmd filetype tex,latex,markdown inoremap <buffer> \ul \underline{}<++><Esc>bli
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

" ........................ spell checking (amix/vimrc) ........................
" toggle and untoggle spell checking
map <Leader>spl :setlocal spell!<CR>

" shortcuts
map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>s? z=

" remove trailing whitespace
nnoremap <Leader>ws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" }}}

" theme and appearance {{{
" -----------------------------------------------------------------------------

set termguicolors
syntax enable
set background=dark
colorscheme solardust

" }}}

" functions and mappings{{{
" -----------------------------------------------------------------------------

" slightly easier way to swap split panes
function! MarkWindow()
    let g:marked_window = winnr()
endfunction

function! SwapWindow()
    "mark current position
    let current_window = winnr()
    let current_buffer = bufnr( "%" )
    execute g:marked_window . "wincmd w"
    let marked_buffer = bufnr( "%" )
    "hide and open so that we aren't prompted and keep history
    execute 'hide buf' current_buffer
    "switch to dest and shuffle source->dest
    execute current_window . "wincmd w"
    execute 'hide buf' marked_buffer
endfunction

" delete the nth line above and insert
function! DeleteLine(position)
    let cursor_position=getpos('.')
    let delete_line = a:position
    execute 'normal! ' . delete_line . 'k0D'
    " call setpos('.', cursor_position)
endfunction

for position in range(1, 9)
    execute 'nnoremap <Leader>d' . position . ' : call DeleteLine(' . position . ')<CR>'
endfor

" move the current line to the nth line of the paragraph
function! MoveLine(position)
    let cursor_position=getpos('.')
    let previous_blank_line=search('^$', 'bn')
    let target_line=previous_blank_line + a:position - 1
    execute 'move' . target_line
    call setpos('.', cursor_position)
endfunction

for position in range(1, 9)
    execute 'nnoremap <Leader>m' . position . ' : call MoveLine(' . position . ')<CR>'
endfor

function! JumpToIndentMatch(inc)
    let current_position = getpos('.')
    let current_line = current_position[1]
    let match_indent = 0

    " Look for a line with the same indent level whithout going out of the buffer
    while !match_indent && current_line != line('$') + 1 && current_line != -1
        let current_line += a:inc
        let match_indent = indent(current_line) == indent('.')
    endwhile

    " If a line is found go to this line
    if (match_indent)
        let current_position[1] = current_line
        call setpos('.', current_position)
    endif
endfunction

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
  nnoremap <silent> <buffer> q :q<CR>
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

" press * or # to search for current visual selection (amix/vimrc)
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
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all=0
        set showmode
        set laststatus=2
        set showcmd
    endif
endfunction

" ......................... functional mappings ..........................
nnoremap <silent> <Leader>mw :call MarkWindow()<CR>
nnoremap <silent> <Leader>pw :call SwapWindow()<CR>

nnoremap <silent> <Leader>ji :call JumpToIndentMatch(1)<CR>
nnoremap <silent> <Leader>ki :call JumpToIndentMatch(-1)<CR>

nnoremap <Leader>n :call RenameFile()<CR>

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <Leader>spf :call FixLastSpellingError()<CR>

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>

" }}}
