" Functions

" Fix the last spelling error (from christoomey's vim plugin talk)
function! FixLastSpellingError()
    normal! mm[s1z=`m
endfunction

nnoremap <leader>sf :call FixLastSpellingError()<CR>

" Determine highlight group of text under the cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

nnoremap <leader>hg :call <SID>SynStack()<CR>

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

nnoremap <leader>n :call RenameFile()<CR>

" Close all empty buffers
" Called with :Lex to close the empty buffers it creates
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

nnoremap <silent> <leader>cb :call DeleteEmptyBuffers()<CR>

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
