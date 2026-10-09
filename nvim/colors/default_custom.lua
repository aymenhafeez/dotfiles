local nvim_set_hl = vim.api.nvim_set_hl

local utils       = require("utils")
local lighter     = utils.lighter
local darker      = utils.darker
local mod         = utils.modify_colour


local background       = "#202326"
local foreground       = "#d1d1d1"

local surface_bg       = mod(background, 15)
local element_selected = mod(background, 30)
local active_line_bg   = surface_bg

local border           = mod(background, 60)
local lighterborder    = mod(border, 100)

local text_disabled    = "#66606b"
local icon_muted       = "#a1a1a1"


local comment             = "#7a7380"
local attribute           = "#a093c7"
local constant            = "#9177b5"
local constructor         = "#a3db81"
local func                = "#a3db81"
local keyword             = "#FAC03B"
local number              = "#9177b5"
local operator            = "#a3db81"
local punctuation         = "#a1a1a1"
local punctuation_special = "#66606b"
local green               = "#37ad82"
local string_escape       = "#FAC03B"
local string_special      = "#ffb354"
local type_color          = "#7398dd"
local tag                 = "#ffb354"

local scrollbar_color     = mod("#202326", 50)

local error_red           = "#c15959"
local warning_yellow      = "#FAC03B"
local warning_red         = "#ff3f55"
local bg_red_subtle       = "#312426"
local bg_yellow_intense   = "#2f2a22"
local bg_blue_subtle      = "#252b35"
local bg_cyan_subtle      = "#232e31"
local bg_green_subtle     = "#212e27"
local type_blue           = "#00d5ff"
local cyan                = "#00c595"

local diff_add_bg         = "#41525a"
local diff_change_bg      = "#585249"
local diff_delete_bg      = "#4f434a"
local diff_text_bg        = "#373f48"

vim.g.terminal_color_0    = "#000000"
vim.g.terminal_color_1    = keyword
vim.g.terminal_color_2    = "#b8cc52"
vim.g.terminal_color_3    = "#e7c547"
vim.g.terminal_color_4    = "#36a3d9"
vim.g.terminal_color_5    = foreground
vim.g.terminal_color_6    = "#95e6cb"
vim.g.terminal_color_7    = "#f0f0f0"
vim.g.terminal_color_8    = mod(comment, 40)
vim.g.terminal_color_9    = "#ff6565"
vim.g.terminal_color_10   = "#eafe84"
vim.g.terminal_color_11   = "#fff779"
vim.g.terminal_color_12   = "#68d5ff"
vim.g.terminal_color_13   = "#ffa3aa"
vim.g.terminal_color_14   = "#c7fffd"
vim.g.terminal_color_15   = "#ffffff"

local highlights          = {
  Normal                             = { fg = foreground, bg = background },

  Bold                               = { bold = true },
  Italic                             = { italic = true },
  Underlined                         = { underline = true },

  Attribute                          = { fg = attribute },
  ColorColumn                        = { bg = surface_bg },
  CursorLine                         = { bg = active_line_bg },
  Error                              = { fg = foreground, bg = error_red },
  LineNr                             = { fg = comment, bg = mod(background, 20) },
  MatchParen                         = { bg = border, bold = true },
  NonText                            = { fg = darker(comment) },
  FloatBorder                        = { link = "WinSeparator" },
  NormalFloat                        = { bg = mod(background, -40) },
  FloatShadow                        = { bg = surface_bg, blend = 80 },
  FloatShadowThrough                 = { bg = surface_bg, blend = 100 },
  Pmenu                              = { bg = mod(surface_bg, 50) },
  PmenuSbar                          = { link = "Pmenu" },
  PmenuSel                           = { fg = background, bg = foreground, bold = true },
  PmenuThumb                         = { bg = surface_bg },
  SpecialKey                         = { fg = surface_bg },
  SpellBad                           = { undercurl = true, sp = error_red },
  SpellCap                           = { undercurl = true, sp = warning_yellow },
  SpellLocal                         = { undercurl = true, sp = warning_yellow },
  SpellRare                          = { undercurl = true, sp = warning_yellow },
  Visual                             = { bg = "NvimDarkGray4" },
  VisualNonText                      = { bg = "NvimDarkGray4", fg = lighter(comment) },
  VisualNOS                          = { bg = "NvimDarkGray4" },

  DiagnosticOk                       = { fg = green },
  DiagnosticWarn                     = { fg = warning_yellow },
  DiagnosticError                    = { fg = error_red },
  DiagnosticInfo                     = { fg = type_color },
  DiagnosticHint                     = { fg = icon_muted },
  DiagnosticUnderlineOk              = { sp = green, undercurl = true },
  DiagnosticUnderlineWarn            = { sp = warning_yellow, undercurl = true },
  DiagnosticUnderlineError           = { sp = error_red, undercurl = true },
  DiagnosticUnderlineInfo            = { sp = type_color, undercurl = true },
  DiagnosticUnderlineHint            = { sp = icon_muted, undercurl = true },
  DiagnosticDeprecated               = { sp = error_red, strikethrough = true },

  DiagnosticVirtualTextError         = { fg = warning_red, bg = bg_red_subtle },
  DiagnosticVirtualTextWarn          = { fg = warning_yellow, bg = bg_yellow_intense },
  DiagnosticVirtualTextInfo          = { fg = cyan, bg = bg_blue_subtle },
  DiagnosticVirtualTextHint          = { fg = type_blue, bg = bg_cyan_subtle },
  DiagnosticVirtualTextOk            = { fg = green, bg = bg_green_subtle },

  LspReferenceText                   = { bg = border },
  LspReferenceRead                   = { bg = border },
  LspReferenceWrite                  = { bg = border },
  LspSignatureActiveParameter        = { underline = true, bold = true, sp = foreground },
  LspCodeLens                        = { link = "Comment" },
  LspCodeLensSeparator               = { link = "Comment" },
  LspInlayHint                       = { fg = surface_bg },
  ["@lsp.type.namespace"]            = { link = "Identifier" },
  ["@lsp.type.operator"]             = { link = "Operator" },

  CursorColumn                       = { bg = surface_bg },
  CursorLineNr                       = { fg = foreground, bg = lighter(background) },
  CursorLineSign                     = { bg = lighter(background) },
  Folded                             = { fg = surface_bg },
  FoldColumn                         = { fg = surface_bg, bg = background },
  SignColumn                         = { bg = mod(background, 20) },

  Scrollbar                          = { fg = scrollbar_color, bg = scrollbar_color },
  ScrollbarThumb                     = { fg = mod(scrollbar_color, 20), bg = scrollbar_color },

  Directory                          = { fg = type_color },

  ErrorMsg                           = { fg = foreground, bg = error_red },
  ModeMsg                            = { fg = foreground, bold = true },
  MoreMsg                            = { fg = green },
  Question                           = { fg = foreground },
  WarningMsg                         = { fg = background, bg = warning_yellow },
  WildMenu                           = { fg = green, bg = surface_bg },
  WinBar                             = { fg = text_disabled, bg = background },
  WinBarNC                           = { fg = text_disabled, bg = background },

  StatusLine                         = { fg = foreground, bg = mod(element_selected, 40) },
  StatusLineNC                       = { fg = text_disabled, bg = element_selected },
  StatusLineTerm                     = { link = "StatusLine" },
  StatusLineTermNC                   = { link = "StatusLineNC" },

  IncSearch                          = { fg = surface_bg, bg = keyword, underline = true },
  CurSearch                          = { fg = surface_bg, bg = keyword },
  Search                             = { fg = foreground, bg = type_color },

  TabLine                            = { fg = text_disabled, bg = mod(background, -20) },
  TabLineFill                        = { fg = text_disabled, bg = mod(background, -20) },
  TabLineSel                         = { fg = foreground, bg = mod(background, -20), bold = true },

  Title                              = { fg = keyword },

  WinSeparator                       = { fg = mod(foreground, -40), bg = background },

  QuickFixLine                       = { bg = keyword, fg = surface_bg },

  Boolean                            = { link = "Keyword" },
  Character                          = { fg = green },
  Comment                            = { fg = lighter(comment) },
  -- Conceal                            = { fg = text_disabled },
  Conceal                            = { link = "String" },
  Conditional                        = { link = "Keyword" },
  Constant                           = { fg = constant },
  Decorator                          = { fg = attribute },
  Define                             = { link = "PreProc" },
  Delimiter                          = { fg = punctuation },
  Exception                          = { fg = keyword },
  Float                              = { fg = number },
  Function                           = { fg = func },
  Identifier                         = { fg = foreground },
  Include                            = { link = "PreProc" },
  Keyword                            = { fg = keyword, bold = true },
  Label                              = { fg = keyword },
  Number                             = { fg = number },
  Operator                           = { fg = operator },
  PreProc                            = { fg = number },
  Repeat                             = { link = "Keyword" },
  Special                            = { fg = string_special },
  SpecialChar                        = { fg = string_escape },
  SpecialComment                     = { fg = comment },
  Statement                          = { fg = keyword },
  StorageClass                       = { fg = keyword },
  String                             = { fg = mod(type_color, 50) },
  Structure                          = { link = "Type" },
  Tag                                = { fg = tag },
  Todo                               = { fg = warning_yellow },
  Type                               = { fg = type_color },
  Typedef                            = { fg = type_color },
  Annotation                         = { link = "Decorator" },
  Macro                              = { link = "Define" },
  PreCondit                          = { link = "PreProc" },
  Variable                           = { link = "Identifier" },
  Constructor                        = { fg = constructor },

  ["@attribute"]                     = { link = "Attribute" },
  ["@constant.builtin"]              = { link = "Constant" },
  ["@constructor"]                   = { link = "Constructor" },
  ["@constant.macro"]                = { link = "Macro" },
  ["@function.builtin"]              = { link = "Function" },
  ["@variable.builtin"]              = { link = "Keyword" },
  ["@markup.link"]                   = { fg = type_color, underline = true },
  ["@module"]                        = { link = "Identifier" },
  ["@punctuation.special"]           = { fg = punctuation_special },
  ["@type.builtin"]                  = { link = "@type" },
  ["@string"]                        = { link = "String" },

  cIncluded                          = { link = "Include" },
  cOperator                          = { link = "Operator" },
  cPreCondit                         = { link = "PreCondit" },
  cConstant                          = { link = "Constant" },
  ["@lsp.type.macro.c"]              = {},
  ["@keyword.conditional.ternary.c"] = { link = "Operator" },

  dosiniHeader                       = { fg = keyword },
  dosiniLabel                        = { link = "Type" },

  dtBooleanKey                       = { fg = type_color },
  dtExecKey                          = { fg = type_color },
  dtLocaleKey                        = { fg = type_color },
  dtNumericKey                       = { fg = type_color },
  dtTypeKey                          = { fg = type_color },
  dtDelim                            = { link = "Delimiter" },
  dtLocaleValue                      = { link = "Keyword" },
  dtTypeValue                        = { link = "Keyword" },


  DiffAdd                                = { bg = diff_add_bg },
  DiffChange                             = { bg = diff_change_bg },
  DiffDelete                             = { fg = warning_red, bg = diff_delete_bg },
  DiffText                               = { bg = diff_text_bg },

  Added                                  = { link = "DiffAdd" },
  Changed                                = { link = "DiffChange" },
  Removed                                = { link = "DiffDelete" },

  ["@attribute.elixir"]                  = { link = "Decorator" },

  gitconfigVariable                      = { fg = type_color },
  gitrebaseFixup                         = { fg = green },
  gitrebaseExec                          = { fg = green },
  gitrebaseReword                        = { fg = warning_yellow },

  luaFunc                                = { link = "Function" },

  ["@markup.link.label.markdown_inline"] = { link = "@markup.link.label" },
  ["@markup.link.markdown_inline"]       = { link = "@markup.link" },
  ["@markup.raw.markdown_inline"]        = { fg = func, bg = surface_bg },

  perlPackageDecl                        = { fg = type_color },

  podCmdText                             = { fg = type_color },
  podVerbatimLine                        = { fg = foreground },
  podFormat                              = { link = "Keyword" },

  pythonBuiltin                          = { link = "Type" },
  pythonEscape                           = { link = "SpecialChar" },

  rustAttribute                          = { link = "Attribute" },
  rustEnum                               = { fg = type_color, bold = true },
  rustMacro                              = { fg = func, bold = true },
  rustModPath                            = { fg = type_color },
  rustPanic                              = { fg = keyword, bold = true },
  rustTrait                              = { fg = type_color },
  rustCommentLineDoc                     = { link = "Comment" },
  rustDerive                             = { link = "rustAttribute" },
  rustEnumVariant                        = { link = "rustEnum" },
  rustEscape                             = { link = "SpecialChar" },
  rustQuestionMark                       = { link = "Keyword" },
  ["@module.rust"]                       = { link = "Identifier" },

  shCmdParenRegion                       = { link = "Delimiter" },
  shCmdSubRegion                         = { link = "Delimiter" },
  shDerefSimple                          = { link = "Identifier" },
  shDerefVar                             = { link = "Identifier" },

  sqlKeyword                             = { link = "Keyword" },
  sqlSpecial                             = { link = "Keyword" },

  ["@variable.parameter.vimdoc"]         = { fg = green },

  ["@attribute.zig"]                     = { link = "Keyword" },


  gitcommitDiscardedFile      = { fg = error_red },
  gitcommitUntrackedFile      = { fg = error_red },
  gitcommitSelectedFile       = { fg = green },

  GitSignsAdd                 = { bg = mod(background, 20), fg = green },
  GitSignsChange              = { bg = mod(background, 20), fg = warning_yellow },
  GitSignsDelete              = { bg = mod(background, 20), fg = error_red },
  GitSignsCurrentLineBlame    = { fg = comment },

  MiniIndentscopeSymbol       = { fg = border },
  MiniFilesNormal             = { bg = background },

  DapStoppedLine              = { bg = text_disabled, underline = true },
  DapStoppedSign              = { fg = surface_bg, bg = foreground },
  DapBreakpoint               = { bg = surface_bg },

  TreesitterContext           = { bg = background },
  TreesitterContextLineNumber = { bg = mod(background, 20), bold = true },
  TreesitterContextSeparator  = { fg = lighterborder },



  TelescopeNormal     = { fg = darker(foreground), bg = background },
  TelescopeBorder     = { link = "FloatBorder" },
  TelescopeSelection  = { link = "PmenuSel" },
  TelescopeMatching   = { fg = lighter(foreground), bold = true },

  FzfLuaBackdrop      = { bg = background },
  FzfLuaCursorLine    = { link = "CursorLine" },
  FzfLuaFzfCursorLine = { link = "CursorLine" },
  FzfLuaLivePrompt    = { fg = "fg" },
  FzfLuaFzfPrompt     = { fg = "fg" },
  FzfLuaFzfPointer    = { fg = func },

  texDelim            = { fg = green },
  texEnvArgName       = { fg = green, bold = true },
}

for group, opts in pairs(highlights) do
  nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "sitruuna"
