
" some changes to the default colorscheme
function! highlightgroups#termcolors() abort
    hi clear spellbad
    hi spellbad ctermbg=none ctermfg=yellow cterm=underline
    hi visual ctermbg=19
    hi conceal ctermbg=none
    hi signcolumn ctermbg=0
    hi statusline ctermbg=251 ctermfg=232 cterm=none
    hi statuslinenc ctermbg=239 ctermfg=250 cterm=none
    hi vertsplit ctermbg=none ctermfg=lightgrey  cterm=none
    hi string ctermbg=none ctermfg=173
    hi User1 ctermbg=251 ctermfg=232 cterm=bold
endfunction

" determine highlight group of text under the cursor
function! highlightgroups#synstack()
    if !exists("*synstack")
        return
        endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
