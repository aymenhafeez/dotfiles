" Global highlight groups
" -----------------------

function! CustomHighlighting()
    hi clear SpellBad
    hi SpellBad                         ctermfg=11      cterm=underline
    hi Visual           ctermbg=19
    hi LineNr           ctermbg=None    ctermfg=243
    hi CursorLine       ctermbg=248     ctermfg=232     cterm=None
    hi CursorLineNr     ctermbg=None    ctermfg=243
    hi VertSplit        ctermbg=None    ctermfg=247     cterm=None
    hi StatusLine       ctermbg=250     ctermfg=232     cterm=None
    hi StatusLineNC     ctermbg=238     ctermfg=248     cterm=None
    hi StatusLineTerm   ctermbg=249     ctermfg=232     cterm=None
    hi StatusLineTermNc ctermbg=250     ctermfg=239     cterm=reverse
    hi tabline          ctermbg=249     ctermfg=232     cterm=bold
    hi tablinefill      ctermbg=249    ctermfg=232      cterm=bold
    hi tablinesel       ctermbg=239     ctermfg=250     cterm=bold
    hi Pmenu            ctermbg=249     ctermfg=232
    hi PmenuSel         ctermbg=241     ctermfg=255
    hi String           ctermfg=173
    hi SignColumn       ctermbg=233
    hi org_heading1                     ctermfg=Magenta cterm=bold
    hi Conceal          ctermbg=None
endfunction
call CustomHighlighting()
set background=dark

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
