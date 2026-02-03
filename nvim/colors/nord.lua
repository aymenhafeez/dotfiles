local nvim_set_hl = vim.api.nvim_set_hl

local background = "#2e3440"
local foreground = "#eceff4"

local black = "#3b4252"

local lightblack = "#424B5E"

local lighterblack = "#b3c3dd"

local brightblack = "#4c566a"

local brighterblack = "#616e88"

local brightestblack = "#6f7e9c"

local darkwhite = "#d8dee9"

local white = "#e5e9f0"

local brightwhite = "#eceff4"

local brightcyan = "#8fbcbb"

local cyan = "#88c0d0"

local blue = "#81a1c1"

local lightblue = "#94b9dd"
local lighterblue = "#c2d2e3"

local darkblue = "#5e81ac"

local red = "#bf616a"

local orange = "#d08770"

local yellow = "#ebcb8b"

local green = "#a3be8c"

local magenta = "#b48ead"

local dark_cyan = "#25747d"
local dark_red = "#a13131"
local dark_yellow = "#9a6b16"
local dark_purple = "#8f36a9"

vim.g.terminal_color_0 = background
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = blue
vim.g.terminal_color_5 = cyan
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = foreground
vim.g.terminal_color_8 = black
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = green
vim.g.terminal_color_11 = yellow
vim.g.terminal_color_12 = blue
vim.g.terminal_color_13 = magenta
vim.g.terminal_color_14 = cyan
vim.g.terminal_color_15 = brightwhite

local highlights = {
  Normal                                 = { fg = foreground, bg = background },

  Bold                                   = { bold = true },
  Italic                                 = { italic = true },
  Underlined                             = { underline = true },

  Attribute                              = { fg = darkwhite },
  ColorColumn                            = { bg = black },
  CursorLine                             = { bg = black },
  Error                                  = { fg = foreground, bg = red },
  LineNr                                 = { fg = brightblack, bg = background },
  MatchParen                             = { bg = brightblack, bold = true },
  NonText                                = { fg = brightblack },
  FloatBorder                            = { fg = brighterblack, blend = 15 },
  NormalFloat                            = { link = "Normal" },
  FloatShadow                            = { bg = black, blend = 80 },
  FloatShadowThrough                     = { bg = black, blend = 100 },
  Pmenu                                  = { link = "Normal" },
  PmenuBorder                            = { link = "FloatBorder" },
  PmenuSbar                              = { link = "Pmenu" },
  PmenuSel                               = { fg = black, bg = foreground, bold = true, reverse = false },
  PmenuThumb                             = { bg = black },
  SpecialKey                             = { fg = brightblack },
  SpellBad                               = { undercurl = true, sp = red },
  SpellCap                               = { undercurl = true, sp = yellow },
  SpellLocal                             = { undercurl = true, sp = yellow },
  SpellRare                              = { undercurl = true, sp = yellow },
  Visual                                 = { bg = lightblack },
  VisualNOS                              = { bg = lightblack },

  DiagnosticOk                           = { fg = green },
  DiagnosticWarn                         = { fg = yellow },
  DiagnosticError                        = { fg = red },
  DiagnosticInfo                         = { fg = blue },
  DiagnosticHint                         = { fg = "NvimLightBlue" },

  DiagnosticUnderlineOk                  = { sp = green, undercurl = true },
  DiagnosticUnderlineWarn                = { sp = yellow, undercurl = true },
  DiagnosticUnderlineError               = { sp = red, undercurl = true },
  DiagnosticUnderlineInfo                = { sp = blue, undercurl = true },
  DiagnosticUnderlineHint                = { sp = lightblue, undercurl = true },
  DiagnosticDeprecated                   = { sp = red, strikethrough = true },

  DiagnosticVirtualTextOk                = { fg = green, bg = "#2d3833" },
  DiagnosticVirtualTextWarn              = { fg = yellow, bg = "#3a3832" },
  DiagnosticVirtualTextError             = { fg = red, bg = "#3a3032" },
  DiagnosticVirtualTextInfo              = { fg = blue, bg = "#303745" },
  DiagnosticVirtualTextHint              = { fg = lightblue, bg = "#31373f" },

  DiagnosticWarnScrollbar                = { fg = yellow, bg = brightestblack },
  DiagnosticErrorScrollbar               = { fg = red, bg = brightestblack },
  DiagnosticInfoScrollbar                = { fg = blue, bg = brightestblack },
  DiagnosticHintScrollbar                = { fg = lightblue, bg = brightestblack },

  LspReferenceText                       = { bg = brightblack },
  LspReferenceRead                       = { bg = brightblack },
  LspReferenceWrite                      = { bg = brightblack },
  LspSignatureActiveParameter            = { underline = true, bold = true, sp = foreground },
  LspCodeLens                            = { link = "Comment" },
  LspCodeLensSeparator                   = { link = "Comment" },
  LspInlayHint                           = { fg = brightblack },
  ["@lsp.type.namespace"]                = { link = "Identifier" },
  ["@lsp.type.operator"]                 = { link = "Operator" },
  ["@lsp.mod.defaultLibrary"]            = { fg = yellow },

  CursorColumn                           = { bg = black },
  CursorLineNr                           = { fg = foreground, bg = background },
  Folded                                 = { fg = brightblack },
  FoldColumn                             = { fg = brightblack, bg = background },
  SignColumn                             = { fg = black, bg = background },

  Directory                              = { fg = blue },

  EndOfBuffer                            = { fg = background },
  ErrorMsg                               = { fg = red, bg = background },
  ModeMsg                                = { fg = foreground, bold = false },
  MoreMsg                                = { fg = cyan },
  Question                               = { fg = foreground },
  WarningMsg                             = { fg = yellow, bg = background },
  WildMenu                               = { fg = cyan, bg = black },
  WinBar                                 = { fg = foreground, bg = background },
  WinBarNC                               = { fg = brightblack, bg = background },

  StatusLine                             = { fg = lighterblack, bg = black },
  StatusLineNC                           = { fg = brightestblack, bg = black },

  IncSearch                              = { fg = black, bg = cyan, underline = true },
  CurSearch                              = { fg = black, bg = cyan },
  Search                                 = { fg = brightwhite, bg = darkblue },

  TabLine                                = { fg = brighterblack, bg = background },
  TabLineFill                            = { fg = brighterblack, bg = background },
  TabLineSel                             = { fg = foreground, bg = brightblack, bold = true },

  Title                                  = { fg = green, bold = true },

  WinSeparator                           = { fg = brightblack },

  QuickFixLine                           = { link = "Visual" },

  User1                                  = { fg = red, bg = black, bold = true },
  User2                                  = { fg = blue, bg = black, bold = true },
  User3                                  = { fg = foreground, bg = black, bold = true },
  User4                                  = { fg = black, bg = yellow },
  User5                                  = { fg = yellow, bg = black, bold = true },
  User6                                  = { fg = lighterblack, bg = black },
  User7                                  = { fg = foreground, bg = black, bold = true },
  User8                                  = { fg = foreground, bg = brightblack },
  User9                                  = { fg = foreground, bg = black },

  Boolean                                = { fg = orange },
  Character                              = { fg = green },
  Comment                                = { fg = brightestblack, italic = true },
  Conceal                                = { fg = orange, bold = false },
  Conditional                            = { link = "Keyword" },
  Constant                               = { fg = yellow },
  Decorator                              = { fg = orange },
  Define                                 = { link = "PreProc" },
  Delimiter                              = { fg = brightwhite },
  Exception                              = { fg = blue },
  Float                                  = { fg = magenta },
  Function                               = { fg = cyan },
  Identifier                             = { fg = lighterblue },
  Include                                = { link = "PreProc" },
  Keyword                                = { fg = blue },
  Label                                  = { fg = darkblue },
  Number                                 = { fg = magenta },
  Operator                               = { fg = white },
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
  ["@function.builtin"]                  = { fg = yellow },
  ["@variable.builtin"]                  = { link = "Keyword" },
  ["@variable.member"]                   = { fg = lightblue },
  ["@variable.parameter"]                = { fg = white, bold = true },
  ["@markup.link"]                       = { fg = blue, underline = true },
  ["@module"]                            = { link = "Identifier" },
  ["@punctuation.special"]               = { fg = brightwhite },
  ["@type.builtin"]                      = { link = "@type" },

  ["@module.latex"]                      = { fg = blue },
  ["@punctuation.special.latex"]         = { fg = blue },

  asciidocAttributeEntry                 = { link = "Attribute" },
  asciidocAttributeList                  = { link = "Attribute" },
  asciidocAttributeRef                   = { link = "Attribute" },
  asciidocHLabel                         = { fg = blue },
  asciidocListingBlock                   = { fg = brightcyan },
  asciidocMacroAttributes                = { link = "Attribute" },
  asciidocOneLineTitle                   = { fg = cyan },
  asciidocPassthroughBlock               = { fg = blue },
  asciidocQuotedMonospaced               = { fg = brightcyan },
  asciidocTriplePlusPassthrough          = { fg = brightcyan },
  asciidocAdmonition                     = { link = "Keyword" },
  asciidocBackslash                      = { link = "Keyword" },
  asciidocMacro                          = { link = "Keyword" },
  asciidocQuotedBold                     = { link = "Bold" },
  asciidocQuotedEmphasized               = { link = "Italic" },
  asciidocQuotedMonospaced2              = { link = "asciidocQuotedMonospaced" },
  asciidocQuotedUnconstrainedBold        = { link = "asciidocQuotedBold" },
  asciidocQuotedUnconstrainedEmphasized  = { link = "asciidocQuotedEmphasized" },
  asciidocURL                            = { link = "markdownLinkText" },

  cIncluded                              = { link = "Include" },
  cOperator                              = { link = "Operator" },
  cPreCondit                             = { link = "PreCondit" },
  cConstant                              = { link = "Constant" },
  cBlock                                 = { fg = brightcyan },
  ["@keyword.function"]                  = { fg = lightblue },
  ["@keyword.return"]                    = { fg = lightblue },
  ["@keyword.conditional"]               = { fg = lightblue },
  ["@lsp.type.macro.c"]                  = { fg = brightcyan },
  ["@keyword.conditional.ternary.c"]     = { link = "Operator" },

  cmakeGeneratorExpression               = { fg = darkblue },

  csPreCondit                            = { link = "PreCondit" },
  csType                                 = { link = "Type" },
  csXmlTag                               = { link = "SpecialComment" },

  cssAttributeSelector                   = { link = "Attribute" },
  cssDefinition                          = { fg = brightcyan },
  cssIdentifier                          = { fg = brightcyan, underline = true },
  cssStringQ                             = { fg = brightcyan },
  cssAttr                                = { link = "Keyword" },
  cssBraces                              = { link = "Delimiter" },
  cssClassName                           = { link = "Type" },
  cssColor                               = { link = "Number" },
  cssProp                                = { link = "cssDefinition" },
  cssPseudoClass                         = { link = "cssDefinition" },
  cssPseudoClassId                       = { link = "cssPseudoClass" },
  cssVendor                              = { link = "Keyword" },

  dosiniHeader                           = { fg = cyan },
  dosiniLabel                            = { link = "Type" },

  dtBooleanKey                           = { fg = brightcyan },
  dtExecKey                              = { fg = brightcyan },
  dtLocaleKey                            = { fg = brightcyan },
  dtNumericKey                           = { fg = brightcyan },
  dtTypeKey                              = { fg = brightcyan },
  dtDelim                                = { link = "Delimiter" },
  dtLocaleValue                          = { link = "Keyword" },
  dtTypeValue                            = { link = "Keyword" },

  DiffAdd                                = { fg = green, bg = background },
  DiffChange                             = { fg = yellow, bg = background },
  DiffDelete                             = { fg = red, bg = background },
  DiffText                               = { fg = blue, bg = background },

  Added                                  = { link = "DiffAdd" },
  Changed                                = { link = "DiffChange" },
  Removed                                = { link = "DiffDelete" },

  ["@attribute.elixir"]                  = { link = "Decorator" },

  gitconfigVariable                      = { fg = brightcyan },
  gitrebaseFixup                         = { fg = cyan },
  gitrebaseExec                          = { fg = cyan },
  gitrebaseReword                        = { fg = yellow },

  goBuiltins                             = { fg = brightcyan },
  goConstants                            = { link = "Keyword" },

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

  jsGlobalNodeObjects                    = { fg = cyan },
  jsBrackets                             = { link = "Delimiter" },
  jsFuncCall                             = { link = "Function" },
  jsFuncParens                           = { link = "Delimiter" },
  jsThis                                 = { link = "Keyword" },
  jsNoise                                = { link = "Delimiter" },
  jsPrototype                            = { link = "Keyword" },
  jsRegexpString                         = { link = "SpecialChar" },

  jsonKeyword                            = { fg = brightcyan },
  jsonCommentError                       = { link = "Comment" },

  lessClass                              = { link = "Type" },
  lessAmpersand                          = { link = "Keyword" },
  lessCssAttribute                       = { link = "Attribute" },
  lessFunction                           = { link = "Function" },
  cssSelectorOp                          = { link = "Keyword" },

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

  sassClass                              = { link = "Type" },
  sassId                                 = { fg = brightcyan, underline = true },
  sassAmpersand                          = { link = "Keyword" },
  sassClassChar                          = { link = "Delimiter" },
  sassControl                            = { link = "Keyword" },
  sassControlLine                        = { link = "Keyword" },
  sassExtend                             = { link = "Keyword" },
  sassFor                                = { link = "Keyword" },
  sassFunctionDecl                       = { link = "Keyword" },
  sassFunctionName                       = { link = "Function" },
  sassidChar                             = { link = "sassId" },
  sassInclude                            = { link = "SpecialChar" },
  sassMixinName                          = { link = "Function" },
  sassMixing                             = { link = "SpecialChar" },
  sassReturn                             = { link = "Keyword" },

  shCmdParenRegion                       = { link = "Delimiter" },
  shCmdSubRegion                         = { link = "Delimiter" },
  shDerefSimple                          = { link = "Identifier" },
  shDerefVar                             = { link = "Identifier" },

  sqlKeyword                             = { link = "Keyword" },
  sqlSpecial                             = { link = "Keyword" },

  tsxAttrib                              = { fg = brightcyan },
  tsxEqual                               = { link = "Operator" },
  tsxIntrinsicTagName                    = { link = "htmlTag" },
  tsxTagName                             = { link = "tsxIntrinsicTagName" },

  typescriptBOMWindowMethod              = { fg = cyan },
  typescriptClassName                    = { link = "Type" },
  typescriptDecorator                    = { fg = orange },
  typescriptInterfaceName                = { fg = brightcyan, bold = true },
  typescriptRegexpString                 = { fg = yellow },
  typescriptOperator                     = { link = "Operator" },
  typescriptBinaryOp                     = { link = "Operator" },
  typescriptAssign                       = { link = "Operator" },
  typescriptMember                       = { link = "Identifier" },
  typescriptDOMStorageMethod             = { link = "Identifier" },
  typescriptArrowFuncArg                 = { link = "Identifier" },
  typescriptGlobal                       = { link = "typescriptClassName" },
  typescriptBOMWindowProp                = { link = "Function" },
  typescriptArrowFuncDef                 = { link = "Function" },
  typescriptAliasDeclaration             = { link = "Function" },
  typescriptPredefinedType               = { link = "Type" },
  typescriptTypeReference                = { link = "typescriptClassName" },
  typescriptTypeAnnotation               = { link = "Structure" },
  typescriptDocNamedParamType            = { link = "SpecialComment" },
  typescriptDocNotation                  = { link = "Keyword" },
  typescriptDocTags                      = { link = "Keyword" },
  typescriptImport                       = { link = "Keyword" },
  typescriptExport                       = { link = "Keyword" },
  typescriptTry                          = { link = "Keyword" },
  typescriptVariable                     = { link = "Keyword" },
  typescriptBraces                       = { link = "Normal" },
  typescriptObjectLabel                  = { link = "Normal" },
  typescriptCall                         = { link = "Normal" },
  typescriptClassHeritage                = { link = "typescriptClassName" },
  typescriptFuncTypeArrow                = { link = "Structure" },
  typescriptMemberOptionality            = { link = "Structure" },
  typescriptNodeGlobal                   = { link = "typescriptGlobal" },
  typescriptTypeBrackets                 = { link = "Structure" },

  vimAugroup                             = { fg = brightcyan },
  vimMapRhs                              = { fg = brightcyan },
  vimNotation                            = { fg = brightcyan },
  vimFunc                                = { link = "Function" },
  vimFunction                            = { link = "Function" },
  vimUserFunc                            = { link = "Function" },

  ["@variable.parameter.vimdoc"]         = { fg = cyan },

  xmlAttrib                              = { fg = brightcyan },
  xmlCdataStart                          = { fg = brighterblack, bold = true },
  xmlNamespace                           = { fg = brightcyan },
  xmlAttribPunct                         = { link = "Delimiter" },
  xmlCdata                               = { link = "Comment" },
  xmlCdataCdata                          = { link = "xmlCdataStart" },
  xmlCdataEnd                            = { link = "xmlCdataStart" },
  xmlEndTag                              = { link = "xmlTagName" },
  xmlProcessingDelim                     = { link = "Keyword" },
  xmlTagName                             = { link = "Keyword" },

  yamlBlockMappingKey                    = { fg = brightcyan },
  yamlBool                               = { link = "Keyword" },
  yamlDocumentStart                      = { link = "Keyword" },
  yamlKey                                = { fg = brightcyan },

  ["@attribute.zig"]                     = { link = "Keyword" },


  gitcommitDiscardedFile      = { fg = red },
  gitcommitUntrackedFile      = { fg = red },
  gitcommitSelectedFile       = { fg = green },

  GitSignsAdd                 = { fg = green, bg = background },
  GitSignsChange              = { fg = yellow, bg = background },
  GitSignsDelete              = { fg = red, bg = background },
  GitSignsCurrentLineBlame    = { fg = brighterblack },

  MiniIndentscopeSymbol       = { fg = brightblack },
  MiniPickMatchCurrent        = { bg = brightblack },

  TreesitterContext           = { bg = background, blend = 10 },
  TreesitterContextLineNumber = { link = "CursorLineNr" },
  TreesitterContextSeparator  = { link = "WinSeparator" },

  BlinkCmpMenu                = { fg = darkwhite, bg = background },
  BlinkCmpMenuSelection       = { link = "PmenuSel" },
  BlinkCmpLabelMatch          = { fg = yellow, bold = true, reverse = false },
  BlinkCmpGhostText           = { link = "Comment" },
  BlinkCmpMenuBorder          = { link = "FloatBorder" },
  BlinkCmpDocBorder           = { link = "FloatBorder" },
  BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },

  BlinkCmpKindStruct          = { fg = yellow, bg = brightblack },
  BlinkCmpKindFunction        = { fg = blue, bg = brightblack },
  BlinkCmpKindText            = { fg = orange, bg = brightblack },
  BlinkCmpKindClass           = { fg = yellow, bg = brightblack },
  BlinkCmpKindValue           = { fg = orange, bg = brightblack },
  BlinkCmpKindEnum            = { fg = yellow, bg = brightblack },
  BlinkCmpKindInterface       = { fg = yellow, bg = brightblack },
  BlinkCmpKindMethod          = { fg = cyan, bg = brightblack },
  BlinkCmpKindUnit            = { fg = red, bg = brightblack },
  BlinkCmpKindConstant        = { fg = foreground, bg = brightblack },
  BlinkCmpKindField           = { fg = blue, bg = brightblack },
  BlinkCmpKindModule          = { fg = yellow, bg = brightblack },
  BlinkCmpKindKeyword         = { fg = magenta, bg = brightblack },
  BlinkCmpKindEnumMember      = { fg = foreground, bg = brightblack },
  BlinkCmpKindProperty        = { fg = blue, bg = brightblack },
  BlinkCmpKindOperator        = { fg = orange, bg = brightblack },
  BlinkCmpKindReference       = { fg = foreground, bg = brightblack },
  BlinkCmpKindSnippet         = { fg = foreground, bg = brightblack },
  BlinkCmpKindTypeParameter   = { fg = yellow, bg = brightblack },
  BlinkCmpKindVariable        = { fg = foreground, bg = brightblack },

  FzfLuaBorder                = { link = "FloatBorder" },
  FzfLuaFzfMatch              = { fg = yellow, bold = true },

  texDelim                    = { fg = cyan },
  texEnvArgName               = { fg = cyan, bold = true },
  texFileOpt                  = { fg = orange },
  texFileArg                  = { fg = green },
  texTCBZone                  = { fg = yellow },
}

for group, opts in pairs(highlights) do
  nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "nord"
