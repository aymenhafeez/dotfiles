" Custom functions and mappings
" -----------------------------

" Fix the last spelling error (from christoomey's vim plugin talk)
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

nnoremap <Leader>sf :call FixLastSpellingError()<CR>

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

" copy file path
function! CopyFilePath()
    let @" = expand("%:p")
    echo 'File path copied to " register'
endfunction

nnoremap yZ :call CopyFilePath()<CR>

" copy filename
function! CopyFileName()
    let @" = expand("%")
    echo 'File name copied to " register'
endfunction
nnoremap yY :call CopyFileName()<CR>

" cycle through line number types (Greg Hurrell)
function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

nnoremap <leader>ln :call CycleNumbering()<CR>

" Paste the output of a command into current buffer
function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        silent put=message
    endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Toggle statusline
let s:hide_status=0
function! ToggleStatus() abort
    if s:hide_status==0
        let s:hide_status=1
        set laststatus=1
        set showmode
        set ruler
        set showcmd
    else
        let s:hide_status=0
        set laststatus=2
        set noshowmode
        set ruler
        set showcmd
    endif
endfunction

nnoremap <leader>ts :call ToggleStatus()<CR>

" Easier navigation and use of user manual
" (from Chris Toomey's Vim config)
function! HelpWithHelp()
    wincmd _ " Maximze the help on open
    " 8 wincmd <
    nnoremap <buffer> <tab> :call search('\|.\{-}\|', 'w')<cr>:noh<cr>2l
    nnoremap <buffer> <S-tab> F\|:call search('\|.\{-}\|', 'wb')<cr>:noh<cr>2l
    nnoremap <buffer> <cr> <c-]>
    nnoremap <buffer> <bs> <c-T>
    nnoremap <buffer> q :q<CR>
    setlocal nonumber
endfunction
