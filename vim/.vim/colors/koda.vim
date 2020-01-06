hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "koda"
set background=dark

" == Color Definition ==
let s:kd_bg = ["#272a32", "236"]
let s:kd_bg_shade = ["#3f424b", "238"]
let s:kd_black = ["#1e2127", "235"]
let s:kd_grey = ["#75787b", "243"]
let s:kd_white = ["#d9ccbb", "251"]
let s:kd_mint =  ["#83bf86", "108"]
let s:kd_teal = ["#6ac5aa", "79"]
let s:kd_light_blue = ["#5a9be8", "68"]
let s:kd_blue = ["#5b86bb", "67"]
let s:kd_red = ["#e64337", "167"]
let s:kd_light_red = ["#ff4a3d", "203"]
let s:kd_orange = ["#ffa015", "214"]
let s:kd_yellow = ["#ffcf56", "221"]
let s:kd_green = ["#a8c53d", "149"]
let s:kd_magenta = ["#dc6a76", "168"]
let s:kd_pink = ["#f27868", "209"]

" == Defaults ==
" -- Bold text? --
if !exists("g:koda_bold")
  let g:koda_bold = 1
endif

if get(g:, "koda_bold", 1)
  let s:bold = "bold"
else
  let s:bold = ""
endif

" -- Italics? --
if !exists("g:koda_italic")
  if has("gui_running") || $TERM_ITALICS == "true"
    let g:koda_italic = 1
  else
    let g:koda_italic = 0
  endif
endif

if get(g:, "koda_italic", 1)
  let s:italic = "italic"
else
  let s:italic = ""
endif

" -- Underlines? --
if get(g:, "koda_underline", 1)
  let s:underline = "underline"
else
  let s:underline = ""
endif

" -- Italicize comments? --
let s:italicize_comments = ""
if exists("g:koda_italicize_comments")
  if g:koda_italicize_comments == 1
    let s:italicize_comments = s:italic
  endif
endif

" == Highlight function ==
function! s:hi(group, fg, bg, attr)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg[0]
    exec "hi " . a:group . " ctermfg=" . a:fg[1]
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg[0]
    exec "hi " . a:group . " ctermbg=" . a:bg[1]
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfunction


" == Predefine hi groups to use with hi link ==
call s:hi("KodaGrey", s:kd_grey, "", "")
call s:hi("KodaWhite", s:kd_white, "", "")
call s:hi("KodaMint", s:kd_mint, "", "")
call s:hi("KodaTeal", s:kd_teal, "", "")
call s:hi("KodaLightBlue", s:kd_light_blue, "", "")
call s:hi("KodaBlue", s:kd_blue, "", "")
call s:hi("KodaRed", s:kd_red, "", "")
call s:hi("KodaLightRed", s:kd_light_red, "", "")
call s:hi("KodaOrange", s:kd_orange, "", "")
call s:hi("KodaYellow", s:kd_yellow, "", "")
call s:hi("KodaGreen", s:kd_green, "", "")
call s:hi("KodaMagenta", s:kd_magenta, "", "")
call s:hi("KodaPink", s:kd_pink, "", "")

" == UI ==
" -- Attributes --
call s:hi("Bold",      "", "", s:bold)
call s:hi("Italic",    "", "", s:italic)
call s:hi("Underline", "", "", s:underline)

" -- Editor --
call s:hi("ColorColumn",  "",          s:kd_black,    "")
call s:hi("Conceal",      s:kd_white,  "",            "")
call s:hi("Cursor",       s:kd_bg,     s:kd_white,    "")
call s:hi("CursorColumn", "",          s:kd_black,    "")
call s:hi("CursorIM",     s:kd_bg,     s:kd_white,    "")
call s:hi("CursorLine",   "",          s:kd_black,    "")
call s:hi("Directory",    s:kd_blue,   "",            "")
call s:hi("EndOfBuffer",  s:kd_bg,     "",            "")
call s:hi("MatchParen",   s:kd_red,    s:kd_bg,       "")
call s:hi("NonText",      s:kd_grey,   "",            "")
call s:hi("Normal",       s:kd_white,  s:kd_bg,       "")
call s:hi("PMenu",        s:kd_white,  s:kd_grey,     "")
call s:hi("PMenuSel",     s:kd_teal,   s:kd_grey,     "")
call s:hi("PmenuSbar",    s:kd_white,  s:kd_grey,     "")
call s:hi("PmenuThumb",   s:kd_teal,   s:kd_grey,     "")
call s:hi("SpecialKey",   s:kd_grey,   "",            "")
call s:hi("SpellBad",     s:kd_red,    s:kd_bg,       "")
call s:hi("SpellCap",     s:kd_yellow, s:kd_bg,       "")
call s:hi("SpellLocal",   s:kd_white,  s:kd_bg,       "")
call s:hi("SpellRare",    s:kd_white,  s:kd_bg,       "")
call s:hi("Visual",       "",          s:kd_bg_shade, "")
call s:hi("VisualNOS",    "",          s:kd_grey,     "")
call s:hi("Whitespace",   s:kd_grey,   s:kd_bg,       "")

" -- Diff --
" call s:hi("DiffAdd", s:kd_white, s:kd_bg, "", "", "", "")
" call s:hi("DiffChange", s:kd_white, s:kd_bg, "", "", "", "")
" call s:hi("DiffDelete", s:kd_white, s:kd_bg, "", "", "", "")
" call s:hi("DiffText", s:kd_white, s:kd_bg, "", "", "", "")


" -- Fold/Gutter --
call s:hi("LineNr",       s:kd_grey,       s:kd_bg,    "")
call s:hi("CursorLineNr", s:kd_white,      s:kd_bg,    "")
call s:hi("Folded",       s:kd_grey,       s:kd_black, s:bold)
call s:hi("FoldColumn",   s:kd_grey,       s:kd_bg,    "")
call s:hi("SignColumn",   s:kd_grey,       s:kd_bg,    "")

" -- Status/Messages --
call s:hi("ErrorMsg",         s:kd_red,    s:kd_bg,    "")
call s:hi("WarningMsg",       s:kd_yellow, s:kd_bg,    "")
call s:hi("ModeMsg",          s:kd_white,  "",         "")
call s:hi("MoreMsg",          s:kd_white,  "",         "")
call s:hi("Question",         s:kd_white,  "",         "")
call s:hi("StatusLine",       s:kd_mint,   s:kd_black,  "")
call s:hi("StatusLineNC",     s:kd_white,  s:kd_black, "")
call s:hi("StatusLineTerm",   s:kd_teal,   s:kd_grey,  "")
call s:hi("StatusLineTermNC", s:kd_white,  s:kd_black, "")
call s:hi("WildMenu",         s:kd_teal,   s:kd_black, "")

" -- Search --
call s:hi("IncSearch",  s:kd_black, s:kd_teal, "")
call s:hi("Search",     s:kd_black, s:kd_blue, "")
call s:hi("Substitute", s:kd_black, s:kd_blue, "")

" -- Windows/Tabs --
call s:hi("TabLine",     s:kd_white, s:kd_black, "")
call s:hi("TabLineFill", s:kd_white, s:kd_black, "")
call s:hi("TabLineSel",  s:kd_teal,  s:kd_grey,  "")
call s:hi("Title",       s:kd_white, "",         "")
call s:hi("VertSplit",   s:kd_grey,  s:kd_grey,  "")


" -- Neovim --
call s:hi("healthError",   s:kd_red,    s:kd_black, "")
call s:hi("healthSuccess", s:kd_green,  s:kd_black, "")
call s:hi("healthWarning", s:kd_yellow, s:kd_black, "")
call s:hi("TermCursorNC",  "",          s:kd_black, "")

" -- Vim8 terminal colors --
if has("terminal")
  let g:terminal_ansi_colors = [s:kd_black[0], s:kd_red[0], s:kd_green[0], s:kd_yellow[0], s:kd_blue[0], s:kd_magenta[0], s:kd_teal[0], s:kd_white[0], s:kd_grey[0], s:kd_red[0], s:kd_green[0], s:kd_yellow[0], s:kd_blue[0], s:kd_magenta[0], s:kd_mint[0], s:kd_white[0]]
endif

" -- Neovim terminal colors --
if has("nvim")
  let g:terminal_color_0 = s:kd_black[0]
  let g:terminal_color_1 = s:kd_red[0]
  let g:terminal_color_2 = s:kd_green[0]
  let g:terminal_color_3 = s:kd_yellow[0]
  let g:terminal_color_4 = s:kd_blue[0]
  let g:terminal_color_5 = s:kd_magenta[0]
  let g:terminal_color_6 = s:kd_teal[0]
  let g:terminal_color_7 = s:kd_white[0]
  let g:terminal_color_8 = s:kd_grey[0]
  let g:terminal_color_9 = s:kd_red[0]
  let g:terminal_color_10 = s:kd_green[0]
  let g:terminal_color_11 = s:kd_yellow[0]
  let g:terminal_color_12 = s:kd_blue[0]
  let g:terminal_color_13 = s:kd_magenta[0]
  let g:terminal_color_14 = s:kd_mint[0]
  let g:terminal_color_15 = s:kd_white[0]
endif

" == Language Base Groups ==
call s:hi("Comment", s:kd_grey, "", s:italicize_comments)

hi! link Boolean   KodaMint
hi! link Character KodaMint
hi! link Constant  KodaMint
hi! link Float     KodaMint
hi! link Number    KodaMint
hi! link String    KodaGreen

call s:hi("Function", s:kd_yellow, "", s:bold)
hi! link Identifier KodaWhite

hi! link Conditional KodaPink
hi! link Exception   KodaPink
hi! link Keyword     KodaPink
hi! link Label       KodaPink
hi! link Operator    KodaPink
hi! link Repeat      KodaPink
hi! link Statement   KodaPink

hi! link Define    KodaLightBlue
hi! link Include   KodaLightBlue
hi! link PreProc   KodaLightBlue
hi! link Macro     Define
hi! link PreCondit PreProc

hi! link StorageClass KodaLightBlue
hi! link Structure    KodaLightBlue
hi! link Type         KodaLightBlue
hi! link Typedef      KodaLightBlue

hi! link Delimiter      KodaWhite
hi! link Special        KodaTeal
hi! link SpecialChar    KodaTeal
hi! link SpecialComment KodaTeal
hi! link Tag            KodaWhite
hi! link Todo           KodaGreen
hi! link Ignore         KodaGrey

" == Language Specific Colors ==
" -- Python --
hi! link pythonExClass        KodaRed
hi! link pythonClassVar       KodaGrey
hi! link pythonDecorator      KodaBlue
hi! link pythonDottedName     KodaBlue

" == Tools Specific Colors ==
" -- ALE --
hi! link ALEError           KodaRed
hi! link ALEErrorSign       KodaRed
hi! link ALEErrorSignLineNr KodaRed

hi! link ALEWarning        KodaOrange
hi! link ALEWarningSign    KodaOrange
hi! link ALEWarningSignNr  KodaOrange

hi! link ALEInfo            KodaLightBlue
hi! link ALEInfoSign        KodaLightBlue
hi! link ALEInfoSignLineNr  KodaLightBlue

" -- vim-startify --
hi! link StartifyBracket KodaWhite
hi! link StartifyFile KodaMint
hi! link StartifyFooter KodaWhite
hi! link StartifyHeader KodaWhite
hi! link StartifyNumber KodaLightBlue
hi! link StartifyPath KodaTeal
hi! link StartifySection KodaMagenta
hi! link StartifySelect KodaYellow
hi! link StartifySlash KodaWhite
hi! link StartifySpecial KodaWhite
hi! link StartifyVar KodaMint
