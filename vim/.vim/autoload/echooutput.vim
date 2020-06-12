

" Paste the output of a command into current buffer
function! echooutput#tabmessage(cmd) abort
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        silent put=message
    endif
endfunction
