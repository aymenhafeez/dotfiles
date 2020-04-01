
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
