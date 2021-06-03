" LaTeX highlighting

function! HighLightGroups() abort
    " hi texBeginEnd      ctermfg=lightyellow
    hi texBeginEndName  ctermfg=cyan
    hi texMathMatcher   ctermfg=111
    hi Delimiter        ctermfg=24
    hi texMathZoneE     ctermfg=173
    hi texStatement     ctermfg=116
    hi texInputFile     ctermfg=lightyellow
    hi texNewCmd        ctermfg=lightyellow
    hi texCmdName       ctermfg=lightyellow
    hi texError         ctermfg=darkred ctermbg=None cterm=underline
    hi texOnlyMath      ctermbg=none
    hi conceal          ctermbg=none                 cterm=bold
endfunction
call HighLightGroups()
