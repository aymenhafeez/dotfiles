vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"

local nvim_set_hl = vim.api.nvim_set_hl

local mod = require("utils").modify_colour

local background = "#2e3440"
local foreground = "#eceff4"

local background_dark = mod(background, -20)
local black = "#3b4252"
local lightblack = "#434c5e"
local lighterblack = "#8A96AA"
local lightestblack = "#b3c3dd"
local brightblack = "#4c566a"
local brighterblack = "#616e88"
local brightestblack = "#6f7e9c"
local darkblack = "#232831"
local darkwhite = "#d8dee9"
local white = "#e5e9f0"
local brightwhite = "#eceff4"
local brightcyan = "#8fbcbb"
local cyan = "#88c0d0"
local blue = "#81a1c1"
local darkblue = "#5e81ac"
local red = "#bf616a"
local orange = "#d08770"
local yellow = "#ebcb8b"
local green = "#a3be8c"
local magenta = "#b48ead"

local diff_add = "#41525a"
local diff_change = "#585249"
local diff_remove = "#4f434a"
local diff_text = "#373f48"

vim.g.terminal_color_0 = background
vim.g.terminal_color_1 = yellow
vim.g.terminal_color_2 = yellow
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = blue
vim.g.terminal_color_5 = foreground
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = foreground
vim.g.terminal_color_8 = brighterblack
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = green
vim.g.terminal_color_11 = cyan
vim.g.terminal_color_12 = blue
vim.g.terminal_color_13 = foreground
vim.g.terminal_color_14 = cyan
vim.g.terminal_color_15 = brightwhite

local writing_ft = { tex = true, markdown = true, text = true }
local is_writing = writing_ft[vim.bo.filetype]

local highlights = {
  Normal                                 = { fg = foreground, bg = background },
  -- TerminalNormal                         = { bg = background_dark },

  Bold                                   = { bold = true },
  Italic                                 = { italic = true },
  Underlined                             = { underline = true },

  Attribute                              = { fg = darkwhite },
  ColorColumn                            = { bg = black },
  CursorLine                             = { bg = black },
  Error                                  = { fg = foreground, bg = red },
  FloatBorder                            = { fg = lightestblack, bg = background },
  LineNr                                 = { fg = brightblack, bg = background },
  MatchParen                             = { bg = brightblack, bold = true },
  NonText                                = { fg = brightblack },
  NormalFloat                            = vim.o.winborder == "rounded" and { bg = background } or
      { bg = background_dark },
  -- SidebarNormal                          = { bg = background_dark },
  Pmenu                                  = vim.o.winborder == "rounded" and { bg = background } or { bg = lightblack },
  -- PmenuSbar                              = { fg = background},
  PmenuThumb                             = { fg = background, background = foreground },
  PmenuSel                               = { fg = background, bg = foreground },
  PmenuBorder                            = { link = "FloatBorder" },
  PmenuMatch                             = { fg = yellow, bold = true },
  PmenuMatchSel                          = { fg = background, bg = yellow },
  PmenuKindSel                           = { fg = background, bg = foreground },
  PmenuExtraSel                          = { fg = background, bg = foreground },
  SpecialKey                             = { fg = blue },
  SpellBad                               = { undercurl = true, sp = red },
  SpellCap                               = { undercurl = true, sp = yellow },
  SpellLocal                             = { undercurl = true, sp = yellow },
  SpellRare                              = { undercurl = true, sp = yellow },
  Visual                                 = { bg = lightblack },
  VisualNOS                              = { bg = lightblack },
  VisualNonText                          = { bg = lightblack, fg = brighterblack },

  DiagnosticOk                           = { fg = green },
  DiagnosticWarn                         = { fg = yellow },
  DiagnosticError                        = { fg = red },
  DiagnosticInfo                         = { fg = blue },
  DiagnosticHint                         = { fg = darkblue },
  DiagnosticUnderlineOk                  = { sp = green, undercurl = true },
  DiagnosticUnderlineWarn                = { sp = yellow, undercurl = true },
  DiagnosticUnderlineError               = { sp = red, undercurl = true },
  DiagnosticUnderlineInfo                = { sp = blue, undercurl = true },
  DiagnosticUnderlineHint                = { sp = darkblue, undercurl = true },
  DiagnosticDeprecated                   = { sp = red, strikethrough = true },

  LspReferenceText                       = { bg = brightblack },
  LspReferenceRead                       = { bg = brightblack },
  LspReferenceWrite                      = { bg = brightblack },
  LspSignatureActiveParameter            = { underline = true, bold = true, sp = foreground },
  LspCodeLens                            = { link = "Comment" },
  LspCodeLensSeparator                   = { link = "Comment" },
  LspInlayHint                           = { fg = brightblack },

  CursorColumn                           = { bg = black },
  CursorLineNr                           = { fg = foreground, bg = background },
  Folded                                 = { fg = brightblack },
  FoldColumn                             = { fg = lighterblack, bg = background },
  SignColumn                             = { fg = black, bg = background },

  Directory                              = { fg = blue },

  EndOfBuffer                            = { fg = black },
  ErrorMsg                               = { fg = foreground, bg = red },
  ModeMsg                                = { fg = foreground },
  MoreMsg                                = { fg = cyan },
  Question                               = { fg = foreground },

  StatusLine                             = { fg = darkwhite, bg = black },
  StatusLineNC                           = { fg = brightestblack, bg = black },

  WarningMsg                             = { fg = background, bg = yellow },
  WildMenu                               = { fg = cyan, bg = black },
  WinBar                                 = { fg = brightblack, bg = background },
  WinBarNC                               = { fg = brightblack, bg = background },

  IncSearch                              = { fg = black, bg = cyan, underline = true },
  -- CurSearch                              = { fg = black, bg = cyan },
  Search                                 = { fg = brightwhite, bg = darkblue },
  SearchVirtText                         = { fg = yellow, bg = black },

  TabLine                                = { fg = brighterblack, bg = black },
  TabLineFill                            = { fg = brightblack, bg = black },
  TabLineSel                             = { fg = foreground, bg = brightblack, bold = true },

  Title                                  = { fg = cyan },
  WinSeparator                           = { fg = brightblack },
  QuickFixLine                           = { link = "Visual" },

  User1                                  = { fg = red, bold = true },
  User2                                  = { fg = blue, bold = true },
  User3                                  = { fg = foreground, bold = true },
  User4                                  = { fg = foreground, bg = brightblack },
  User5                                  = { fg = yellow, bold = true },
  User6                                  = { fg = blue },
  User8                                  = { fg = foreground, bg = brightblack },
  User9                                  = { fg = foreground },

  Boolean                                = { link = "Keyword" },
  Character                              = { fg = green },
  Comment                                = { fg = brightestblack, italic = true },
  Conceal                                = { fg = cyan },
  Ignore                                 = { fg = background },
  Conditional                            = { link = "Keyword" },
  Constant                               = { fg = darkwhite },
  Decorator                              = { fg = orange },
  Define                                 = { link = "PreProc" },
  Delimiter                              = { fg = brightwhite },
  Exception                              = { fg = blue },
  Float                                  = { fg = magenta },
  Function                               = { fg = cyan },
  Identifier                             = { fg = darkwhite },
  Include                                = { link = "PreProc" },
  Keyword                                = { fg = blue },
  Label                                  = { fg = darkblue },
  Number                                 = { fg = magenta },
  Operator                               = { fg = darkwhite },
  PreProc                                = { fg = darkblue },
  Repeat                                 = { link = "Keyword" },
  Special                                = { fg = yellow },
  SpecialChar                            = { fg = yellow },
  SpecialComment                         = { fg = cyan },
  Statement                              = { fg = blue },
  StorageClass                           = { fg = blue },
  String                                 = { fg = green },
  Structure                              = { link = "Type" },
  Tag                                    = { fg = blue },
  Todo                                   = { fg = yellow },
  Type                                   = { fg = brightcyan },
  Typedef                                = { fg = brightcyan },
  Annotation                             = { link = "Decorator" },
  Macro                                  = { link = "Define" },
  PreCondit                              = { link = "PreProc" },
  Variable                               = { link = "Identifier" },
  Constructor                            = {},

  ["@attribute"]                         = { link = "Attribute" },
  ["@constant.builtin"]                  = { link = "Constant" },
  ["@constructor"]                       = { link = "Function" },
  ["@constant.macro"]                    = { link = "Macro" },
  ["@function.builtin"]                  = { link = "Function" },
  ["@variable.builtin"]                  = { fg = yellow },
  ["@markup.link"]                       = { fg = blue, underline = true },
  ["@module"]                            = { link = "Identifier" },
  ["@punctuation.special"]               = { fg = brightwhite },
  ["@punctuation.special.latex"]         = { fg = cyan },
  ["@type.builtin"]                      = { link = "@type" },

  cIncluded                              = { link = "Include" },
  cOperator                              = { link = "Operator" },
  cPreCondit                             = { link = "PreCondit" },
  cConstant                              = { link = "Constant" },

  Added                                  = { fg = green },
  Changed                                = { fg = yellow },
  Removed                                = { fg = red },

  DiffAdd                                = { bg = diff_add },
  DiffDelete                             = { bg = diff_remove },
  DiffText                               = { bg = diff_text },
  DiffChange                             = { bg = diff_change },

  GitSignsCurrentLineBlame               = { fg = brightestblack },

  gitconfigVariable                      = { fg = brightcyan },
  gitrebaseFixup                         = { fg = cyan },
  gitrebaseExec                          = { fg = cyan },
  gitrebaseReword                        = { fg = yellow },

  htmlArg                                = { fg = brightcyan },
  htmlLink                               = { fg = foreground },
  htmlBold                               = { link = "Bold" },
  htmlEndTag                             = { link = "htmlTag" },
  htmlItalic                             = { link = "Italic" },
  htmlH1                                 = { link = "markdownH1" },
  htmlH2                                 = { link = "markdownH1" },
  htmlH3                                 = { link = "markdownH1" },
  htmlH4                                 = { link = "markdownH1" },
  htmlH5                                 = { link = "markdownH1" },
  htmlH6                                 = { link = "markdownH1" },
  htmlSpecialChar                        = { link = "SpecialChar" },
  htmlTag                                = { link = "Keyword" },
  htmlTagN                               = { link = "htmlTag" },

  luaFunc                                = { link = "Function" },

  ["@markup.link.label.markdown_inline"] = { link = "@markup.link.label" },
  ["@markup.link.markdown_inline"]       = { link = "@markup.link" },
  ["@markup.raw.markdown_inline"]        = { bg = black },

  pandocDefinitionBlockTerm              = { fg = brightcyan },
  pandocTableDelims                      = { fg = brighterblack },
  pandocAtxHeader                        = { link = "markdownH1" },
  pandocBlockQuote                       = { link = "markdownBlockquote" },
  pandocCiteAnchor                       = { link = "Operator" },
  pandocCiteKey                          = { link = "pandocReferenceLabel" },
  pandocDefinitionBlockMark              = { link = "Operator" },
  pandocEmphasis                         = { link = "markdownItalic" },
  pandocFootnoteID                       = { link = "pandocReferenceLabel" },
  pandocFootnoteIDHead                   = { link = "markdownLinkDelimiter" },
  pandocFootnoteIDTail                   = { link = "pandocFootnoteIDHead" },
  pandocGridTableDelims                  = { link = "pandocTableDelims" },
  pandocGridTableHeader                  = { link = "pandocTableDelims" },
  pandocOperator                         = { link = "Operator" },
  pandocPipeTableDelims                  = { link = "pandocTableDelims" },
  pandocReferenceDefinition              = { link = "pandocReferenceLabel" },
  pandocReferenceLabel                   = { link = "markdownLinkText" },
  pandocReferenceURL                     = { link = "markdownUrl" },
  pandocSimpleTableHeader                = { link = "pandocAtxHeader" },
  pandocStrong                           = { link = "markdownBold" },
  pandocTableHeaderWord                  = { link = "pandocAtxHeader" },
  pandocUListItemBullet                  = { link = "Operator" },

  pythonBuiltin                          = { link = "Type" },
  pythonEscape                           = { link = "SpecialChar" },

  rustAttribute                          = { link = "Attribute" },
  rustEnum                               = { fg = brightcyan, bold = true },
  rustMacro                              = { fg = cyan, bold = true },
  rustModPath                            = { fg = brightcyan },
  rustPanic                              = { fg = blue, bold = true },
  rustTrait                              = { fg = brightcyan },
  rustCommentLineDoc                     = { link = "Comment" },
  rustDerive                             = { link = "rustAttribute" },
  rustEnumVariant                        = { link = "rustEnum" },
  rustEscape                             = { link = "SpecialChar" },
  rustQuestionMark                       = { link = "Keyword" },
  ["@module.rust"]                       = { link = "Identifier" },

  sqlKeyword                             = { link = "Keyword" },
  sqlSpecial                             = { link = "Keyword" },
  sqlFold                                = { link = "Special" },

  vimAugroup                             = { fg = brightcyan },
  vimMapRhs                              = { fg = brightcyan },
  vimNotation                            = { fg = brightcyan },
  vimFunc                                = { link = "Function" },
  vimFunction                            = { link = "Function" },
  vimUserFunc                            = { link = "Function" },

  ["@variable.parameter.vimdoc"]         = { fg = cyan },

  yamlBlockMappingKey                    = { fg = brightcyan },
  yamlBool                               = { link = "Keyword" },
  yamlDocumentStart                      = { link = "Keyword" },
  yamlKey                                = { fg = brightcyan },

  ["@attribute.zig"]                     = { link = "Keyword" },

  -- mini.nvim
  MiniIndentscopeSymbol                  = { fg = brightblack },
  MiniPickMatchCurrent                   = { link = "PmenuSel" },
  MiniPickMatchMarked                    = { link = "PmenuMatch" },
  MiniPickMatchRanges                    = { link = "PmenuMatch" },
  MiniFilesCursorLine                    = { link = "PmenuSel" },
  MiniFilesBorder                        = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = background_dark, bg = background_dark },
  MiniFilesTitle                         = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = lighterblack, bg = background_dark },
  MiniFilesTitleFocused                  = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = blue, bg = background_dark, bold = true },

  MiniPickBorder                         = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = background_dark, bg = background_dark },
  MiniPickBorderText                     = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = blue, bg = background_dark },
  MiniPickPromptPrefix                   = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = yellow, bg = background_dark },
  MiniPickPrompt                         = vim.o.winborder == "rounded" and { link = "FloatBorder" } or
      { fg = foreground, bg = background_dark },

  FzfLuaBackDrop                         = { bg = background },
  FzfLuaLivePrompt                       = { fg = foreground },
  FzfLuaBorder                           = { link = "FloatBorder" },
  FzfLuaHeaderText                       = { fg = cyan },
  FzfLuaHeaderBind                       = { fg = cyan },
  FzfLuaBufFlagCur                       = { fg = cyan },
  FzfLuaPathLineNr                       = { fg = foreground },
  FzfLuaPathColNr                        = { fg = foreground },
  FzfLuaFzfPrompt                        = { fg = blue },
  FzfLuaBufFlagAlt                       = { fg = green },
  FzfLuaBufNr                            = { fg = darkwhite },
  FzfLuaFzfSeparator                     = { fg = background },
  FzfLuaFzfScrollbar                     = { link = "PmenuThumb" },
  FzfLuaScrollFloatFull                  = { link = "PmenuThumb" },
  FzfLuaScrollBorderBackCompat           = { link = "PmenuThumb" },
  fzf1                                   = { fg = background, bg = background },
  -- fzf1                                   = { link = "StatusLine" },
  fzf2                                   = { link = "fzf1" },
  fzf3                                   = { link = "fzf1" },
  FzfLuaTitle                            = { link = "fzf1" },
  FzfLuaTitleFlags                       = { link = "fzf1" },
  -- FzfLuaTitle                            = { link = "User8" },
  -- FzfLuaTitleFlags                       = { link = "FzfLuaTitle" },

  SnacksPicker                           = { bg = background_dark },
  SnacksPickerBorder                     = { fg = background_dark, bg = background_dark },
  SnacksPickerInput                      = { bg = background_dark },
  SnacksPickerInputBorder                = { fg = brightblack, bg = background_dark },
  SnacksPickerInputTitle                 = { fg = blue, bg = background_dark },
  SnacksPickerInputCursorline            = { bg = background_dark },
  SnacksPickerTree                       = { fg = brightblack, bg = background_dark },
  SnacksPickerDir                        = { bg = background_dark },
  -- SnacksWinSeparator                     = { fg = background_dark, bg = background_dark },
  SnacksPickerPrompt                     = { fg = brightestblack, bg = background_dark },
  SnacksPickerGitStatusUntracked         = { fg = lightestblack },
  SnacksIndentScope                      = { fg = brighterblack },

  BufferLineOffsetSeparator              = { fg = brightblack, bg = background },
  BufferLineIndicatorVisible             = { bg = background },
  BufferLineFill                         = { bg = background },
  BufferLineBackground                   = { fg = lighterblack, bg = background },
  BufferLineBuffer                       = { fg = lightblack, bg = background },
  BufferLineBufferVisible                = { fg = lighterblack, bg = background },
  BufferLineSeparator                    = { fg = background, bg = background },
  BufferLineSeparatorVisible             = { fg = background, bg = background },
  BufferLineSeparatorSelected            = { fg = background, bg = background },
  BufferLineModified                     = { fg = lighterblack, bg = background },
  BufferLineModifiedVisible              = { fg = lighterblack, bg = background },
  BufferLineModifiedSelected             = { fg = lighterblack, bg = background, underline = false, sp = lightblack },
  BufferLineCloseButton                  = { fg = lighterblack, bg = background },
  BufferLineCloseButtonVisible           = { fg = lighterblack, bg = background },
  BufferLineCloseButtonSelected          = { fg = lighterblack, bg = background, underline = false, sp = lightblack },
  BufferLineTab                          = { fg = lighterblack, bg = background },
  BufferLineTabVisible                   = { fg = lighterblack, bg = background },
  BufferLineTabSelected                  = { fg = foreground, bg = background, bold = true },
  BufferLineTabSeparator                 = { fg = background, bg = background },
  BufferLineTabSeparatorVisible          = { fg = background, bg = background },
  BufferLineTabSeparatorSelected         = { fg = background, bg = background },
  BufferLineOffsetExplorer               = { fg = foreground, bg = background_dark },
  BufferLineOffsetHelp                   = { fg = foreground, bg = background_dark },
  BufferLineOffset                       = { fg = foreground, bg = background },

  -- nvim-treesitter-context
  TreesitterContext                      = { bg = background, underline = true, sp = brightblack },
  TreesitterContextLineNumber            = { bg = background, underline = true, sp = brightblack },
  TreesitterContextSeparator             = { fg = brightblack },

  Scrollbar                              = { fg = black, bg = black },
  ScrollbarThumb                         = { bg = black, fg = brighterblack },

  texOnlyMath                            = { link = "Normal" },
}

for group, opts in pairs(highlights) do
  nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "nord"
