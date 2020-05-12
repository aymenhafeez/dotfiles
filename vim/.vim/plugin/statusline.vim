" Statusline

let g:currentmode={
       \ 'n'  : ' <N> ',
       \ 'v'  : ' <V> ',
       \ 'V'  : ' <V·L> ',
       \ "\<C-V>" : ' <V·B> ',
       \ 'i'  : ' <I> ',
       \ 'R'  : ' <R> ',
       \ 'Rv' : ' <V·R> ',
       \ 'c'  : ' <C> ',
       \ 's'  : ' <S> ',
       \ 'S'  : ' <S·L> ',
       \ "\<C-S>"  : ' <S·B> ',
       \ 'cv' : ' <V·Ex> ',
       \ 'ce' : ' <Ex> ',
       \ 'r' : ' <Prompt> ',
       \ 'rm' : ' <More> ',
       \ 'r?' : ' <C?> ',
       \ '!' : ' <Sh> ',
       \ 'no' : ' <N·Op Pend> ',
       \ 't' : ' <TERM> '
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
        return kbytes . 'kB'
    else
        return bytes . 'B'
    endif
endfunction

set statusline=
    \\ %{&readonly\|\|!&modifiable?&modified?'U:**-':'U:%%-':&modified?'-:**-':'-:---'}
    \\ \ \ %1*%f%*
    \%10{(g:currentmode[mode()])}
    \\ %7P
    \\ of
    \\ %{FileSize()}
    \\ \ (%l,%c)
    \\ \ Tot
    \\ %L
    \\ \ \ \ %{FugitiveStatusline()}
    \\ (%{&fileencoding?&fileencoding:&encoding}/%Y)
    \%=
    \%1*%#warningmsg#%*
    \%*
    \%<
    " \\ [%{&fileformat}]

hi User1 ctermbg=250   ctermfg=232 cterm=bold
