" statusline
" ==========

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
    return kbytes . 'kB'
  else
    return bytes . 'B'
  endif
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
    \\ %{&readonly\|\|!&modifiable?&modified?'U:**-':'U:%%-':&modified?'-:**-':'-:---'}
    \\ \ \ %1*%.23f%*
    \%10{(g:currentmode[mode()])}
    \\ %7P
    \\ of
    \\ %{FileSize()}
    \\ \ (%l,%c)
    \\ \ Tot
    \\ %L
    \\ \ %{FugitiveStatusline()}
    \\ (%{&fileformat}/%Y)
    \%=
    \%1*%#warningmsg#%*
    \%*
    " \\ %{&fileencoding?&fileencoding:&encoding}
    " \\ [%{&fileformat}]
    " \%{LinterStatus()}
    " \\ 
    " \%1*%{SyntasticStatuslineFlag()}%*

hi User1 ctermbg=19   ctermfg=250 cterm=bold
