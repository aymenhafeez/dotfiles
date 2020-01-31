" -------------------------------- statusline ---------------------------------
function! Buf_total_num()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
function! File_size(f)
    let l:size = getfsize(expand(a:f))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.' bytes'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'k'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'm'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
    endif
endfunction

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
" set statusline+=\ %1*%n%*
set statusline+=\ %n
" set statusline+=%{Buf_total_num()}
set statusline+=\ -:---
set statusline+=%{toupper(g:currentmode[mode()])}
set statusline+=%1*%f%*
set statusline+=\ %1*[%-3(%{FileSize()}%)]%*
set statusline+=%m
set statusline+=%=
set statusline+=%1*%#warningmsg#%*
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}]
set statusline+=\ %l:%c
set statusline+=\ 
set statusline+=\ %P
set statusline+=\ 

hi User1 cterm=bold ctermfg=235 ctermbg=249
