" -------------------------------- statusline ---------------------------------

let g:currentmode={
       \ 'n'  : ' <N> ',
       \ 'v'  : ' <V> ',
       \ 'V'  : ' <V·L> ',
       \ "\<C-V>" : ' <V·B> ',
       \ 'i'  : ' <I> ',
       \ 'R'  : ' <R> ',
       \ 'Rv' : ' <V·R> ',
       \ 'c'  : ' <C> ',
       \}

function! TotalNumBuffs()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

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
    \\ %{&readonly\|\|!&modifiable?&modified?':%*-':'U:%%-':&modified?'-:**-':'-:---'}
    \\ \ %1*%f%*
    \\ [%{FileSize()}]
    \\ 
    \\ \ %P
    \\ (%l,%c)
    \\ \ 
    \\ %{toupper(g:currentmode[mode()])}
    \\ %{FugitiveStatusline()}
    \\ %y
    \%=
    \\ %1*%#warningmsg#%*
    \%1*%{SyntasticStatuslineFlag()}%*
    \%*
    \\ \ \ 
    \\ B:%n
    \\ 

hi User1 ctermbg=250 ctermfg=232 cterm=bold 
