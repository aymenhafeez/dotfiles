" LaTeX highlighting

function! HighLightGroups() abort
    hi texBeginEnd      ctermfg=30
    hi texBeginEndName  ctermfg=130
    hi Delimiter        ctermfg=24
    hi texStatement     ctermfg=6
    hi texInputFile     ctermfg=130
    hi texNewCmd        ctermfg=130
    hi texCmdName       ctermfg=130
    hi texError         ctermfg=darkred ctermbg=None cterm=underline
endfunction
call HighLightGroups()

