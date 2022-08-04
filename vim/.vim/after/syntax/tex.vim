" LaTeX highlighting

function! HighLightGroups() abort
    " hi texBeginEnd      ctermfg=yellow
    hi texStatement     guifg=#C678DD ctermfg=170
    hi texSubscripts    guifg=#D19A66 ctermfg=173
    hi texSuperscripts  guifg=#D19A66 ctermfg=173
    hi texTodo          guifg=#BE5046 ctermfg=196
    hi texBeginEnd      guifg=#C678DD ctermfg=170
    hi texBeginEndName  guifg=#61AFEF ctermfg=39
    hi texMathMatcher   guifg=#61AFEF ctermfg=39
    hi texMathDelim     guifg=#61AFEF ctermfg=39
    hi texDelimiter     guifg=#61AFEF ctermfg=39
    hi texSpecialChar   guifg=#D19A66 ctermfg=173
    hi texCite          guifg=#61AFEF ctermfg=39
    hi texRefZone       guifg=#61AFEF ctermfg=39
endfunction
" call HighLightGroups()
