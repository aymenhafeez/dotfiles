" Highlight groups
function! CustomHighlighting()
    hi clear SpellBad
    hi SpellBad         ctermfg=11                   cterm=underline
    hi Visual           ctermbg=237
    hi CursorLineNr     ctermbg=None    ctermfg=241  cterm=None
    hi CursorLine       ctermbg=233                  cterm=None
    hi LineNr           ctermfg=238
    hi VertSplit        ctermfg=248
    " hi StatusLine       ctermbg=246     ctermfg=235  cterm=underline,bold
    " hi StatusLineNC     ctermbg=243     ctermfg=234  cterm=underline
    hi StatusLine       ctermbg=248     ctermfg=235  cterm=bold
    hi StatusLineNC     ctermbg=243     ctermfg=235  cterm=None
    hi Pmenu            ctermfg=250     ctermbg=234
    hi PmenuSel         ctermfg=234     ctermbg=250
    hi SignColumn       ctermbg=233
    hi org_heading1     ctermfg=Magenta              cterm=bold
endfunction
call CustomHighlighting()
set background=light
