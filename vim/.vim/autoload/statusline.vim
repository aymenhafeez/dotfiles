" Statusline:

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

function statusline#statusline() abort
        set statusline=
        \\ %{&readonly\|\|!&modifiable?&modified?'U:**-':'U:%%-':&modified?'-:**-':'-:---'}
        \\ \ \ %1*%f%*
        \%10{(g:currentmode[mode()])}
        \\ %7P
        \\ of
        \\ %{filesize#filesize()}
        \\ \ (%l,%c)
        \\ \ Tot
        \\ %L
        \\ \ \ \ %{FugitiveStatusline()}
        \\ \ (%{&fileencoding?&fileencoding:&encoding}/%Y)
        \%=
        \%1*%#warningmsg#%*
        \%*
        \%<
        " \\ [%{&fileformat}]
        " \\ \ \ %1*%.23f%*
endfunction

hi User1 ctermbg=lightgray ctermfg=232 cterm=bold
