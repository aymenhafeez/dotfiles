
" get size of current file
function! filesize#filesize() abort
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif
    if bytes <= 0
        return '0'
    endif
    if (exists('mbytes'))
        return mbytes . 'MB'
    elseif (exists('kbytes'))
        return kbytes . 'kB'
    else
        return bytes . 'B'
    endif
endfunction
