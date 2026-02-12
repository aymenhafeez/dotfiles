" -------------------------------- statusline ---------------------------------

let g:currentmode={
       \ 'n'  : '-- NORMAL --',
       \ 'v'  : '-- VISUAL --',
       \ 'V'  : '-- V·Line --',
       \ "\<C-V>" : '-- V·Block --',
       \ 'i'  : '-- INSERT --',
       \ 'R'  : '-- R --',
       \ 'Rv' : '-- V·Replace --',
       \ 'c'  : '-- Command --',
       \}

function! FileSize()
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
    return kbytes . 'KB'
  else
    return bytes . 'B'
  endif
endfunction

set statusline=
set statusline+=\ %n\  
set statusline+=%0*%{toupper(g:currentmode[mode()])}
set statusline+=\ %f
set statusline+=\ [%-3(%{FileSize()}%)]
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}]
set statusline+=\ %l:%c
set statusline+=\ %p%%
set statusline+=\ 
