" Global highlight groups
" -----------------------

function! CustomHighlighting()
    hi clear SpellBad
    hi SpellBad                          ctermfg=11  cterm=underline
    hi Normal              ctermbg=232
    hi Visual              ctermbg=19                cterm=none
    hi LineNr              ctermbg=none  ctermfg=243
    hi CursorLine          ctermbg=248   ctermfg=232 cterm=none
    hi CursorLineNr        ctermbg=none  ctermfg=243
    hi VertSplit           ctermbg=none  ctermfg=250 cterm=none
    hi StatusLine          ctermbg=19    ctermfg=250 cterm=none
    hi StatusLineNC        ctermbg=248   ctermfg=232 cterm=none
    hi StatusLineTerm      ctermbg=19    ctermfg=250 cterm=none
    hi StatusLineTermNc    ctermbg=248   ctermfg=232 cterm=none
    hi tabline             ctermbg=249   ctermfg=232 cterm=bold
    hi tablinefill         ctermbg=249   ctermfg=232 cterm=bold
    hi tablinesel          ctermbg=239   ctermfg=250 cterm=bold
    hi Pmenu               ctermbg=249   ctermfg=232
    hi PmenuSel            ctermbg=241   ctermfg=255
    hi String              ctermfg=173
    hi SignColumn          ctermbg=none
    hi org_heading1                      ctermfg=Magenta cterm=bold
    hi Conceal             ctermbg=none
endfunction
call CustomHighlighting()
set background=dark

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
