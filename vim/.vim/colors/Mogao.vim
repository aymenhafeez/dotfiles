"===============================================================================
" Theme: Mogao
" URL: https://github.com/theJian/vim-mogao
" Maintainer: theJian <thejianmail@gmail.com>
" License: GPL
"===============================================================================

let s:info = {}
let s:info.name    = 'Mogao Color Scheme'
let s:info.maintainer  = 'theJian <thejianmail@gmail.com>'
let s:info.url     = 'https://github.com/theJian/vim-mogao'
let s:info.license = 'GPL'

function! g:Mogao()
    for [key, value] in items(s:info)
        echom key . ': ' . value
    endfor
endfunction

command! -nargs=0 Mogao :call g:Mogao()


" Theme ========================================================================

let s:palette = {}
let s:palette.none = 'NONE'
let s:palette.color00 = '#071014'
let s:palette.color01 = '#792423'
let s:palette.color02 = '#1b8c73'
let s:palette.color03 = '#9e7d57'
let s:palette.color04 = '#508ea5'
let s:palette.color05 = '#675e71'
let s:palette.color06 = '#363f37'
let s:palette.color07 = '#bbf2db'
let s:palette.color08 = '#081d22'
let s:palette.color09 = '#f1a19b'
let s:palette.color10 = '#b4ded5'
let s:palette.color11 = '#f8d2a4'
let s:palette.color12 = '#1ca9c9'
let s:palette.color13 = '#c38eac'
let s:palette.color14 = '#809594'
let s:palette.color15 = '#fbf5d9'
let s:palette.foreground = '#adccc6'
let s:palette.background = s:palette.color00
let s:palette.cursorbackground = '#171714'

" Neovim terminal colors
let g:terminal_color_0  = s:palette.color00
let g:terminal_color_1  = s:palette.color01
let g:terminal_color_2  = s:palette.color02
let g:terminal_color_3  = s:palette.color03
let g:terminal_color_4  = s:palette.color04
let g:terminal_color_5  = s:palette.color05
let g:terminal_color_6  = s:palette.color06
let g:terminal_color_7  = s:palette.color07
let g:terminal_color_8  = s:palette.color08
let g:terminal_color_9  = s:palette.color09
let g:terminal_color_10 = s:palette.color10
let g:terminal_color_11 = s:palette.color11
let g:terminal_color_12 = s:palette.color12
let g:terminal_color_13 = s:palette.color13
let g:terminal_color_14 = s:palette.color14
let g:terminal_color_15 = s:palette.color15

let s:ft = {}
let s:ft.none          = 'cterm=NONE gui=NONE'
let s:ft.bold          = 'cterm=bold gui=bold'
let s:ft.underline     = 'cterm=underline gui=underline'
let s:ft.undercurl     = 'cterm=undercurl gui=undercurl'
let s:ft.reverse       = 'cterm=reverse gui=reverse'
let s:ft.italic        = 'cterm=italic gui=italic'
let s:ft.standout      = 'cterm=standout gui=standout'

let s:theme = {
    \   'Boolean'                : ['color07', 'none', 'bold'],
    \   'Character'              : ['color04', 'none', 'italic'],
    \   'ColorColumn'            : ['none', 'color08', 'none'],
    \   'Comment'                : ['color14', 'none', 'italic'],
    \   'Conceal'                : '',
    \   'Conditional'            : ['color09', 'none', 'none'],
    \   'Constant'               : ['color04', 'none'],
    \   'Cursor'                 : ['color15', 'color08'],
    \   'CursorColumn'           : ['none', 'cursorbackground', 'none'],
    \   'CursorLine'             : ['none', 'cursorbackground', 'none'],
    \   'CursorLineNr'           : ['color03', '.'],
    \   'Debug'                  : ['color07', 'color01', 'bold'],
    \   'Delimiter'              : ['color14', 'none', 'none'],
    \   'Directory'              : ['color03', 'none', 'none'],
    \   'EndOfBuffer'            : ['background', 'background'],
    \   'Error'                  : ['color01', 'none', 'none'],
    \   'ErrorMsg'               : ['color15', 'color01', 'none'],
    \   'Exception'              : ['color01', 'none', 'none'],
    \   'Float'                  : ['color07'],
    \   'FoldColumn'             : 'Folded',
    \   'Folded'                 : ['color14', 'none', 'italic'],
    \   'Function'               : ['color03', 'none', 'none'],
    \   'Identifier'             : ['color02', 'none', 'none'],
    \   'Ignore'                 : ['none', 'none'],
    \   'Keyword'                : ['color12', 'none', 'italic'],
    \   'Label'                  : ['color13', 'none', 'italic'],
    \   'LineNr'                 : ['color06', 'background'],
    \   'MatchParen'             : ['color07', 'color08', 'bold'],
    \   'ModeMsg'                : ['color13', 'color05'],
    \   'MoreMsg'                : ['color13', 'color05'],
    \   'Normal'                 : ['foreground', 'background'],
    \   'Number'                 : ['color07'],
    \   'Operator'               : ['color14', 'none', 'none'],
    \   'PMenu'                  : ['color13', 'color08'],
    \   'PMenuSel'               : ['color08', 'color13', 'bold'],
    \   'Preproc'                : ['color05', 'none', 'none'],
    \   'Question'               : '',
    \   'Repeat'                 : ['color10', 'none', 'none'],
    \   'Search'                 : ['color11', 'color03'],
    \   'SignColumn'             : ['color10', 'background', 'none'],
    \   'Special'                : ['color14', 'none', 'none'],
    \   'SpecialChar'            : ['color15', 'none', 'bold'],
    \   'SpecialComment'         : ['color14', 'color08', 'bold'],
    \   'SpecialKey'             : ['color07', 'color06', 'none'],
    \   'Statement'              : ['color11', 'none', 'none'],
    \   'StatusLine'             : ['color07', 'color08', 'none'],
    \   'StatusLineNC'           : ['color06', 'none', 'none'],
    \   'String'                 : ['color04', 'none', 'italic'],
    \   'TabLine'                : ['color14', 'color08', 'none'],
    \   'TabLineFill'            : ['color14', 'color08', 'none'],
    \   'TabLineSel'             : ['color03', 'background', 'bold'],
    \   'Tag'                    : ['color12', 'none', 'underline'],
    \   'Title'                  : ['color04', 'none', 'bold'],
    \   'Todo'                   : ['color15', 'none', 'bold'],
    \   'Type'                   : ['color12', 'color08', 'none'],
    \   'Underlined'             : ['color04', 'none', 'underline'],
    \   'VertSplit'              : ['background', 'color06'],
    \   'Visual'                 : ['color15', 'color03'],
    \   'WarningMsg'             : ['color09', 'none', 'none'],
    \   'WildMenu'               : ['color11', 'color08', 'underline'],
    \   'clojureMacro'           : 'Function',
    \   'conceal_bg'             : '',
    \   'conceal_fg'             : '',
    \   'diffadd_bg'             : '',
    \   'diffadd_fg'             : '',
    \   'diffdelete_bg'          : '',
    \   'diffdelete_fg'          : '',
    \   'difftext_bg'            : '',
    \   'difftext_fg'            : '',
    \   'foldcolumn_bg'          : '',
    \   'foldcolumn_fg'          : '',
    \   'helpHeader'             : 'Title',
    \   'htmlArg'                : ['color02', 'none', 'italic'],
    \   'htmlTagName'            : ['color03', 'none', 'none'],
    \   'htmlTitle'              : 'Title',
    \   'javaScriptBraces'       : 'Delimiter',
    \   'javaScriptEmbed'        : ['color13', 'none', 'none'],
    \   'javaScriptParens'       : 'Delimiter',
    \   'jsxElseOperator'        : ['color09', 'none'],
    \   'jsxIfOperator'          : ['color09', 'none'],
    \   'markdownH1'             : 'Title',
    \   'markdownH2'             : 'Title',
    \   'markdownH3'             : 'Title',
    \   'markdownH4'             : 'Title',
    \   'markdownH5'             : 'Title',
    \   'markdownH6'             : 'Title',
    \   'rustMacro'              : ['color05', 'none', 'italic'],
    \   'spellbad'               : '',
    \   'spellcap'               : '',
    \   'spelllocal'             : '',
    \   'spellrare'              : '',
    \   'typescriptEndColons'    : ['color06', 'none', 'none'],
    \   'typescriptExceptions'   : ['color01', 'none'],
    \   'typescriptNull'         : ['color09', 'none', 'none'],
    \   'typescriptRegexpString' : ['color03', 'none', 'bold'],
    \   'vimHiAttrib'            : ['color01', 'none', 'none'],
    \   'vimOption'              : ['color09', 'none', 'none'],
    \   }

function! s:hi(group, colors)
    let l = len(a:colors)
    if l == 0
        return 0
    endif

    if type(a:colors) == type('')
        exec 'hi! default link ' . a:group . ' ' . a:colors
        return
    endif

    let command = 'hi! ' . a:group

    if a:colors[0] != ""
        let command = command . ' guifg=' . (a:colors[0] == "." ? "fg" : s:palette[a:colors[0]])
    endif

    if l > 1 && a:colors[1] != ""
        " bg highlight if exists
        let command = command . ' guibg=' . (a:colors[1] == "." ? "bg" : s:palette[a:colors[1]])
    endif

    if l > 2 && a:colors[2] != ""
        " font style if exists
        let command = command . ' ' . s:ft[a:colors[2]]
    endif

    exec command
endfunction

function! s:apply_theme()
    set background=dark

    for [k, v] in items(s:theme)
        call s:hi(k, v)
    endfor
endfunction

" Main =========================================================================

highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'Mogao'

highlight conceal guibg=#071014

call s:apply_theme()

hi User1 guibg=#081d22 guifg=#bbf2db gui=bold cterm=bold
