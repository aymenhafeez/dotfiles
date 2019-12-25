" ---------------------------- functions and mappings -------------------------

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

nnoremap <silent> <Leader>mw :call MarkWindow()<CR>
nnoremap <silent> <Leader>pw :call SwapWindow()<CR>

" delete the nth line above
function! DeleteLine(position)
    let cursor_position=getpos('.')
    let delete_line = a:position
    execute 'normal! ' . delete_line . 'k0dd'
    call setpos('.', cursor_position)
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

" jump between matching indents
function! JumpToIndentMatch(inc)
    let current_position = getpos('.')
    let current_line = current_position[1]
    let match_indent = 0

    " look for a line with the same indent level without going out of the buffer
    while !match_indent && current_line != line('$') + 1 && current_line != -1
        let current_line += a:inc
        let match_indent = indent(current_line) == indent('.')
    endwhile

    " if a line is found go to this line
    if (match_indent)
        let current_position[1] = current_line
        call setpos('.', current_position)
    endif
endfunction

nnoremap <silent> <Leader>ji :call JumpToIndentMatch(1)<CR>
nnoremap <silent> <Leader>ki :call JumpToIndentMatch(-1)<CR>

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

nnoremap <Leader>n :call RenameFile()<CR>

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

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

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

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" from christoomey's 'vim plugin' talk
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

nnoremap <Leader>spf :call FixLastSpellingError()<CR>

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

nnoremap <silent> <Leader>h :call ToggleHideAll()<CR>
