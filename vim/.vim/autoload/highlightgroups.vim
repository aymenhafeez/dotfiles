" Some changes to the default colorscheme

function! highlightgroups#termcolors() abort
    hi clear spellbad
    hi spellbad     ctermbg=none      ctermfg=yellow
    " hi normal       ctermbg=232
    hi conceal      ctermbg=none
    hi signcolumn   ctermbg=0
    " hi statusline   ctermbg=lightgray ctermfg=black cterm=none
    hi statuslinenc ctermbg=darkgray ctermfg=white cterm=none
    hi vertsplit    ctermbg=none ctermfg=lightgrey  cterm=none
    hi string       ctermbg=none ctermfg=173
endfunction

