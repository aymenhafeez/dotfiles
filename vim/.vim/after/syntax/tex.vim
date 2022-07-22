" LaTeX highlighting

function! HighLightGroups() abort
    " hi texBeginEnd      ctermfg=yellow
    hi texBeginEndName  ctermfg=cyan
    hi texMathMatcher   ctermfg=111
    hi Delimiter        ctermfg=24
    hi texMathZoneE     ctermfg=173
    hi texStatement     ctermfg=lightcyan
    hi texInputFile     ctermfg=lightyellow
    hi texNewCmd        ctermfg=cyan
    hi texCmdName       ctermfg=lightyellow
    hi texError         ctermfg=darkred ctermbg=None cterm=underline
    hi texOnlyMath      ctermbg=none
    hi conceal          ctermbg=none                 cterm=bold
    hi texComment       ctermfg=darkcyan
endfunction
" call HighLightGroups()
