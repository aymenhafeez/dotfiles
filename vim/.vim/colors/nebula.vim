" -------------------------------------------------
" Name:    nebula.vim
" Author:  github.com/stillwwater
" Version: 1.0
" License: The MIT License (MIT)
"
" Based on the paramount colorcheme:
" https://github.com/owickstrom/vim-colors-paramount
" --------------------------------------------------

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'nebula'

" Palette
let s:black         = { 'gui': '#000000', 'cterm': '16'  }
let s:near_black    = { 'gui': '#0a121d', 'cterm': '234' }
let s:faint_black   = { 'gui': '#1c2b3b', 'cterm': '236' }
let s:light_black   = { 'gui': '#273845', 'cterm': '237' }
let s:medium_blue   = { 'gui': '#3b5166', 'cterm': '239' }
let s:faint_white   = { 'gui': '#a2a4a6', 'cterm': '248' }
let s:near_white    = { 'gui': '#c9cbd1', 'cterm': '254' }
let s:off_white     = { 'gui': '#fafafa', 'cterm': '231' }
let s:white         = { 'gui': '#ffffff', 'cterm': '231' }

" Bright palette
let s:light_purple  = { 'gui': '#bbaaee', 'cterm': '147' }
let s:light_orange  = { 'gui': '#ecc48d', 'cterm': '222' }
let s:light_cyan    = { 'gui': '#8de5ec', 'cterm': '117' }
let s:light_gray    = { 'gui': '#797987', 'cterm': '244' }
let s:light_slate   = { 'gui': '#65737e', 'cterm': '243' }

" Dim palette
let s:dark_purple   = { 'gui': '#9a58de', 'cterm': '98'  }
let s:dark_orange   = { 'gui': '#d19745', 'cterm': '179' }
let s:dark_cyan     = { 'gui': '#20a5ba', 'cterm': '37'  }
let s:dark_gray     = { 'gui': '#767678', 'cterm': '243' }
let s:dark_slate    = { 'gui': '#95a3ae', 'cterm': '109' }

" Other colors
let s:red           = { 'gui': '#d65e76', 'cterm': '168' }
let s:green         = { 'gui': '#a3be8c', 'cterm': '144' }
let s:blue          = { 'gui': '#20bbfc', 'cterm': '39'  }
let s:light_yellow  = { 'gui': '#ffff87', 'cterm': '228' }
let s:dark_yellow   = { 'gui': '#d6c619', 'cterm': '3'   }

if &background == 'dark'
  let s:bg          = s:near_black
  let s:bg_faint    = s:faint_black
  let s:bg_light    = s:dark_gray
  let s:bg_bright   = s:medium_blue
  let s:norm        = s:near_white
  let s:norm_darker = s:light_gray
  let s:purple      = s:light_purple
  let s:orange      = s:light_orange
  let s:cyan        = s:light_cyan
  let s:slate       = s:light_slate
  let s:yellow      = s:light_yellow
else
  let s:bg          = s:off_white
  let s:bg_faint    = s:near_white
  let s:bg_light    = s:white
  let s:bg_bright   = s:faint_white
  let s:norm        = s:light_black
  let s:norm_darker = s:dark_gray
  let s:purple      = s:dark_purple
  let s:orange      = s:dark_orange
  let s:cyan        = s:dark_cyan
  let s:slate       = s:dark_slate
  let s:yellow      = s:dark_yellow
endif

let s:b  = 'bold'
let s:i  = 'italic'
let s:u  = 'underline'
let s:uc = 'undercurl'

" Vim 8 terminal colors
if has('terminal')
  let g:terminal_ansi_colors = [
    \ s:bg.gui,        s:red.gui,  s:green.gui, s:orange.gui,
    \ s:purple.gui,    s:blue.gui, s:cyan.gui,  s:slate.gui,
    \ s:bg_bright.gui, s:red.gui,  s:green.gui, s:yellow.gui,
    \ s:purple.gui,    s:blue.gui, s:cyan.gui,  s:norm.gui]
end

" From https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute 'highlight' a:group
    \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
    \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
    \ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui      : 'NONE')
    \ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp.gui   : 'NONE')
    \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
    \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
    \ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm    : 'NONE')
endfunction

" Common syntax
call s:h('Normal',      { 'bg': s:bg,     'fg': s:norm })
call s:h('Cursor',      { 'bg': s:purple, 'fg': s:norm })
call s:h('Comment',     { 'fg': s:slate                })

call s:h('Constant',    { 'fg': s:cyan })
hi! link Character      Constant
hi! link Number         Constant
hi! link Boolean        Constant
hi! link Float          Constant

call s:h('String',      { 'fg': s:orange })
call s:h('Operator',    { 'fg': s:norm, 'gui': s:b, 'cterm': s:b })
hi! link Function       Normal
hi! link Identifier     Normal

call s:h('Statement',   { 'fg': s:norm_darker })
hi! link Conditional    Statement
hi! link Repeat         Statement
hi! link Label          Statement
hi! link Keyword        Statement
hi! link Exception      Statement

call s:h('Type',        { 'fg': s:purple })
hi! link StorageClass   Type
hi! link Structure      Type
hi! link Typedef        Type
hi! link pythonBuiltin  Type

call s:h('PreProc',     { 'fg': s:norm_darker })
hi! link Include        PreProc
hi! link Define         PreProc
hi! link Macro          PreProc
hi! link PreCondit      PreProc

call s:h('Special',     { 'fg': s:norm_darker })
hi! link SpecialChar    Special
hi! link Tag            Special
hi! link Delimiter      Special
hi! link SpecialComment Special
hi! link Debug          Special

" UI colors
call s:h('Underlined',   { 'fg': s:norm, 'gui': s:u, 'cterm': s:u })
call s:h('Todo',         { 'fg': s:red,  'gui': s:u, 'cterm': s:u })
call s:h('Error',        { 'fg': s:red })
call s:h('IncSearch',    { 'bg': s:yellow, 'fg': s:black})
call s:h('Search',       { 'bg': s:yellow, 'fg': s:black })
call s:h('NonText',      { 'fg': s:bg_bright })
call s:h('Visual',       { 'bg': s:purple, 'fg': s:norm })
call s:h('MatchParen',   { 'bg': s:purple, 'fg': s:norm })
call s:h('StatusLine',   { 'bg': s:bg_faint, 'fg': s:norm, 'gui': s:b, 'cterm': s:b })
call s:h('StatusLineNC', { 'bg': s:bg_faint, 'fg': s:slate })
call s:h('Directory',    { 'fg': s:blue })
call s:h('VertSplit',    { 'bg': s:bg, 'fg': s:bg_bright })
call s:h('LineNr',       { 'fg': s:bg_bright })
call s:h('CursorLineNr', { 'fg': s:slate })
call s:h('Title',        { 'fg': s:blue })
call s:h('WarningMsg',   { 'fg': s:yellow })
call s:h('ErrorMsg',     { 'fg': s:red })
call s:h('Question',     { 'fg': s:blue })
call s:h('DiffAdd',      { 'fg': s:orange })
call s:h('DiffChange',   { 'fg': s:yellow })
call s:h('DiffDelete',   { 'fg': s:red })
call s:h('DiffText',     { 'fg': s:blue })
call s:h('SignColumn',   { 'fg': s:orange })
call s:h('WildMenu',     { 'fg': s:bg, 'bg': s:norm })

if has('gui_running')
  call s:h('SpellBad',   { 'sp': s:red,    'gui': s:uc })
  call s:h('SpellCap',   { 'sp': s:blue,   'gui': s:uc })
  call s:h('SpellRare',  { 'sp': s:orange, 'gui': s:uc })
  call s:h('SpellLocal', { 'sp': s:blue,   'gui': s:uc })
else
  call s:h('SpellBad',   { 'sp': s:red,    'cterm': s:u })
  call s:h('SpellCap',   { 'sp': s:blue,   'cterm': s:u })
  call s:h('SpellRare',  { 'sp': s:orange, 'cterm': s:u })
  call s:h('SpellLocal', { 'sp': s:blue,   'cterm': s:u })
endif

call s:h('Pmenu',        { 'bg': s:bg_faint, 'fg': s:norm })
call s:h('PmenuSel',     { 'bg': s:purple,   'fg': s:white })
call s:h('PmenuSbar',    { 'bg': s:bg_faint, 'fg': s:norm })
call s:h('PmenuThumb',   { 'bg': s:bg_light, 'fg': s:norm })
call s:h('TabLine',      { 'bg': s:bg_faint, 'fg': s:norm })
call s:h('TabLineFill',  { 'bg': s:bg_faint, 'fg': s:norm })
call s:h('TabLineSel',   { 'bg': s:bg_light, 'fg': s:purple })
call s:h('qfLineNr',     { 'fg': s:slate })

" Vim
call s:h('vimCommentTitle',    { 'fg': s:slate, 'gui': s:b, 'cterm': s:b })
call s:h('vimMapMod',          { 'fg': s:norm_darker })
hi link vimMapModKey           vimMapMod
hi link vimNotation            vimMapMod
hi link vimBracket             vimMapMod

" Markdown
call s:h('markdownBold',          { 'fg': s:slate,  'gui': s:b, 'cterm': s:b })
call s:h('markdownBoldItalic',    { 'fg': s:slate,  'gui': s:b, 'cterm': s:b })
call s:h('markdownItalic',        { 'fg': s:slate,  'gui': s:i, 'cterm': s:i })
call s:h('markdownUrl',           { 'fg': s:slate,  'gui': s:u, 'cterm': s:u })
call s:h('markdownH1',            { 'fg': s:purple, 'gui': s:b, 'cterm': s:b })
call s:h('markdownH3',            { 'fg': s:purple })
call s:h('markdownLinkText',      { 'fg': s:cyan })
call s:h('markdownCode',          { 'fg': s:orange })
hi link markdownCodeBlock         markdownCode
hi link markdownCodeDelimiter     markdownCode
hi link markdownLinkDelimiter     Delimiter
hi link markdownLinkTextDelimiter Delimiter
hi link markdownH2                markdownH1
hi link markdownH4                markdownH3
hi link markdownH5                markdownH3
hi link markdownH6                markdownH3

" C++
hi link cppUserTypedefs Type
hi link cppUserStructs  Type

" Cs
hi link csModifier Keyword

" Signify; git-gutter
hi link SignifySignAdd         LineNr
hi link SignifySignDelete      LineNr
hi link SignifySignChange      LineNr
hi link GitGutterAdd           LineNr
hi link GitGutterDelete        LineNr
hi link GitGutterChange        LineNr
hi link GitGutterChangeDelete  LineNr

" vim: fdm=marker:sw=2:sts=2:et

