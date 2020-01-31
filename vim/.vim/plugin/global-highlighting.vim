" " Global highlight groups

function! CustomHighlighting()
    hi clear SpellBad
    hi SpellBad                         ctermfg=11      cterm=underline
    hi Visual           ctermbg=237
    hi CursorLineNr     ctermbg=None    ctermfg=229     cterm=None
    hi CursorLine       ctermbg=234     ctermfg=229     cterm=None
    hi LineNr           ctermbg=None    ctermfg=230
    hi VertSplit                        ctermfg=250
    hi StatusLine       ctermbg=249     ctermfg=236     cterm=bold
    hi StatusLineNC     ctermbg=239     ctermfg=250     cterm=None
    hi Pmenu            ctermbg=234     ctermfg=250
    hi PmenuSel         ctermbg=250     ctermfg=234
    hi SignColumn       ctermbg=233
    hi org_heading1                     ctermfg=Magenta cterm=bold
endfunction
call CustomHighlighting()
set background=dark
