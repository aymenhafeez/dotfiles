" ----------------------- Custom functions and mappings -----------------------

" Delete the nth line above the current position
function! DeleteLine(position)
    let cursor_position=getpos('.')
    let delete_line = a:position
    execute 'normal! ' . delete_line . 'k0dd'
    call setpos('.', cursor_position)
endfunction

for position in range(1, 9)
    execute 'nnoremap <Leader>d' . position . ' : call DeleteLine(' . position . ')<CR>'
endfor

" Move current line n lines up
function! MoveLine(position)
    let cursor_position=getpos('.')
    let move_line = a:position
    execute 'normal! dd' . move_line . 'kP'
    call setpos('.', cursor_position)
endfunction

for position in range(1, 9)
    execute 'nnoremap <Leader>m' . position . ' : call MoveLine(' . position . ')<CR>'
endfor

" Fix the last spelling error (from christoomey's vim plugin talk)
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

nnoremap <Leader>spf :call FixLastSpellingError()<CR>

" Mappings for when using :help user-manual
function! HelpFileHelp()
    wincmd _
    nnoremap <buffer> <tab> :call search('\|.\{-}\|', 'w')<CR>:noh<CR>2l
    nnoremap <buffer> <S-tab> F\|:call search('\|.\{-}\|', 'wb')<CR>:noh<CR>2l
    nnoremap <buffer> <CR> <C-]>
    nnoremap <buffer> <BS> <C-t>
    nnoremap <silent> <buffer> q :q<CR>
    setlocal nonumber
endfunction

" Determine highlight group of text under the cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

nnoremap <leader>hg :call <SID>SynStack()<CR>

" Jump between matching indent groups
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

" Rename the current file
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

" Press * or # to search for the current visual selection (amix/vimrc)
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

" Slightly easier way to move splits around
function! MarkWindow()
    let g:marked_window = winnr()
endfunction

function! SwapWindow()
    " mark current position
    let current_window = winnr()
    let current_buffer = bufnr( "%" )
    execute g:marked_window . "wincmd w"
    let marked_buffer = bufnr( "%" )
    " hide and open so that we aren't prompted and keep history
    execute 'hide buf' current_buffer
    " switch to dest and shuffle source->dest
    execute current_window . "wincmd w"
    execute 'hide buf' marked_buffer
endfunction

nnoremap <silent> <Leader>mw :call MarkWindow()<CR>
nnoremap <silent> <Leader>pw :call SwapWindow()<CR>

" Close all empty buffers
function! DeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufloaded(i) && bufname(i) == '' && getbufline(i, 1, 2) == ['']
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction

nnoremap <silent> <Leader>cb :call DeleteEmptyBuffers()<CR>
