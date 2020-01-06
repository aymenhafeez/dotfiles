" Highlight groups
function! CustomHighlighting()
    hi clear SpellBad
    hi SpellBad         ctermfg=11                   cterm=underline
    hi Visual           ctermbg=237
    hi VertSplit        ctermfg=251
    hi StatusLine       ctermfg=251
    " hi StatusLineNC     ctermfg=248
    hi LineNr           ctermfg=229
    hi CursorLineNR     ctermfg=230
    hi Pmenu            ctermfg=250     ctermbg=234
    hi PmenuSel         ctermfg=234     ctermbg=250
    hi SignColumn       ctermbg=233
    hi org_heading1     ctermfg=Magenta              cterm=underline
endfunction
call CustomHighlighting()
set background=light
