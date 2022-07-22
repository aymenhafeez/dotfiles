
" some changes to the default colorscheme
function! highlightgroups#termcolors() abort
    hi link vimHiGroup vimGroup
    hi link NERDTreeFlags NERDTreeDir
    " hi normal ctermbg=NONE guibg=NONE 
    hi clear spellbad
    hi visual ctermbg=18 ctermfg=NONE
    hi spellbad ctermbg=NONE ctermfg=red cterm=underline guisp=NONE
    hi conceal ctermbg=NONE cterm=bold guibg=NONE
    hi signcolumn ctermbg=NONE guibg=NONE term=NONE gui=NONE
    hi error guibg=NONE ctermbg=NONE
    hi statusline ctermbg=250 ctermfg=232 cterm=NONE
    hi statuslinenc ctermbg=248 ctermfg=238 cterm=reverse
    " hi statuslinenc guibg=NONE
    " hi vertsplit ctermbg=NONE ctermfg=lightgrey  cterm=NONE guibg=NONE
    hi string ctermbg=NONE ctermfg=173
    hi User1 ctermbg=250 ctermfg=232 cterm=bold
    " hi User1 guibg=#373737 guifg=#D4D4D4 gui=bold cterm=bold
    " hi pmenu ctermbg=lightgray ctermfg=black
    " hi pmenusel ctermbg=gray ctermfg=black
    " hi cursorline cterm=NONE ctermbg=18 ctermfg=NONE
    hi nontext ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
endfunction

" determine highlight group of text under the cursor
function! highlightgroups#synstack()
    if !exists("*synstack")
        return
        endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
