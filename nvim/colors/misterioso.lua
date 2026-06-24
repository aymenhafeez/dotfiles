local nvim_set_hl = vim.api.nvim_set_hl
vim.o.background = "dark"

local mod = require("utils").modify_colour

local background = "#2d3743"
local background_light = mod(background, 15)
local background_dark = mod(background, -20)
local foreground = "#e1e1e0"
local black = "#000000"

local cursor_bg = "#415160"
local fringe_bg = "#2e3748"
local highlight_bg = "#338f86"
local region_bg = "#2d4948"
local isearch_bg = "#fcffad"

-- local modeline_bg = "#212931"
local modeline_bg = "#242c35"
local modeline_inactive_bg = "#878787"
local modeline_fg = "#eeeeec"
local header_bg = "#e5e5e5"
local header_fg = "#333333"

local prompt_blue = "#729fcf"
local builtin_cyan = "#23d7d7"
local comment_green = "#74af68"
local constant_teal = "#008b8b"
local function_cyan = "#66e3db"
local keyword_orange = "#ffad29"
local string_orange = "#e67128"
local type_blue = "#34cae2"
local match_blue = "#6C9BEF"
local variable_yellow = "#dbdb95"
local warning_red = "#ff4242"
local red2 = "#ec5f66"
local link_blue = "#59e9ff"
local visited_magenta = "#ed74cd"
local diff_text = "#373f48"
local diff_add = "#41525a"
local diff_change = "#585249"
local diff_remove = "#4f434a"

local bg_red_subtle = "#3d3741"
local bg_yellow_intense = "#3d3f40"
local bg_blue_subtle = "#334a4a"
local bg_cyan_subtle = "#2e464f"
local bg_green_subtle = "#344342"

vim.g.terminal_color_0 = background
vim.g.terminal_color_1 = warning_red
vim.g.terminal_color_2 = variable_yellow
vim.g.terminal_color_3 = variable_yellow
vim.g.terminal_color_4 = type_blue
vim.g.terminal_color_5 = foreground
vim.g.terminal_color_6 = function_cyan
vim.g.terminal_color_7 = foreground
vim.g.terminal_color_8 = modeline_inactive_bg
vim.g.terminal_color_9 = warning_red
vim.g.terminal_color_10 = comment_green
vim.g.terminal_color_11 = variable_yellow
vim.g.terminal_color_12 = type_blue
vim.g.terminal_color_13 = visited_magenta
vim.g.terminal_color_14 = function_cyan
vim.g.terminal_color_15 = foreground

local highlights = {
  Normal                                 = { fg = foreground, bg = background },
  NormalFloat                            = { bg = background_dark },
  TerminalNormal                         = { bg = background_dark },
  SidebarNormal                          = { bg = background_dark },
  DBUINormal                             = { bg = background_dark },
  DBUIOutNormal                          = { bg = background_dark },
  FloatBorder                            = { fg = modeline_inactive_bg, bg = background },

  Bold                                   = { bold = true },
  Underlined                             = { underline = true },

  Cursor                                 = { fg = background, bg = link_blue },
  nCursor                                = { fg = foreground, bg = foreground },
  -- CursorLine                      = { bg = mod(background, 12) },
  CursorLine                             = { bg = region_bg },
  CursorColumn                           = { bg = fringe_bg },
  ColorColumn                            = { bg = background_light },
  LineNr                                 = { fg = modeline_inactive_bg, bg = background_light },
  CursorLineNr                           = { fg = foreground, bg = background_light, bold = true },
  CursorLineFold                         = { fg = foreground, bg = background, bold = true },
  SignColumn                             = { fg = modeline_inactive_bg, bg = background },
  FoldColumn                             = { fg = modeline_inactive_bg, bg = background },
  Folded                                 = {},
  NonText                                = { fg = modeline_inactive_bg },
  SpecialKey                             = { fg = modeline_inactive_bg },
  EndOfBuffer                            = { fg = fringe_bg },
  ModeMsg                                = { fg = foreground, bold = true },
  WinSeparator                           = { fg = cursor_bg, bg = background_light },
  Conceal                                = { fg = variable_yellow },

  ScrollbarThumb                         = { fg = mod(modeline_inactive_bg, 20) },
  Scrollbar                              = { fg = modeline_inactive_bg },

  Visual                                 = { bg = highlight_bg },
  VisualNOS                              = { fg = foreground, bg = region_bg },
  VisualNonText                          = { fg = mod(modeline_inactive_bg, 20), bg = highlight_bg },
  Search                                 = { fg = foreground, bg = highlight_bg },
  CurSearch                              = { fg = black, bg = isearch_bg },
  IncSearch                              = { fg = black, bg = isearch_bg },
  MatchParen                             = { bg = prompt_blue, fg = foreground, bold = true },

  StatusLine                             = { fg = modeline_fg, bg = modeline_bg, underline = false, sp = mod(modeline_bg, -10) },
  -- StatusLineNC                           = { fg = mod(modeline_fg, -10), bg = modeline_inactive_bg, underline = false, sp = mod(modeline_inactive_bg, 20) },
  -- StatusLine                             = { fg = modeline_fg, bg = modeline_inactive_bg, underline = false, sp = mod(modeline_inactive_bg, 20) },
  StatusLineNC                           = { fg = mod(modeline_fg, -30), bg = modeline_bg, underline = false, sp = mod(modeline_bg, -10) },
  StatuslineTerm                         = { fg = modeline_fg, bg = modeline_bg },
  WinBar                                 = { link = "Tabline" },
  WinBarNC                               = { link = "Tabline" },
  TabLine                                = { fg = comment_green, bg = modeline_bg },
  TabLineFill                            = { fg = foreground, bg = modeline_bg },
  -- TabLineSel                      = { fg = header_fg, bg = header_bg, bold = true },
  TabLineSel                             = { fg = "#ffffff", bg = background, bold = true, italic = true },
  Pmenu                                  = { bg = cursor_bg },
  PmenuSel                               = { fg = foreground, bg = highlight_bg },
  PmenuSbar                              = { bg = fringe_bg },
  PmenuThumb                             = { bg = modeline_inactive_bg },
  PmenuBorder                            = { link = "FloatBorder" },
  PmenuMatch                             = { fg = match_blue, bold = true },

  Directory                              = { fg = prompt_blue },
  Title                                  = { fg = variable_yellow },
  Question                               = { fg = prompt_blue, bold = true },
  MoreMsg                                = { fg = function_cyan },
  WarningMsg                             = { fg = warning_red, bold = true },
  Error                                  = { fg = warning_red, bold = true },
  ErrorMsg                               = { fg = warning_red, bold = true },

  Comment                                = { fg = comment_green },
  Constant                               = { fg = constant_teal },
  String                                 = { fg = string_orange },
  Character                              = { link = "String" },
  Number                                 = { fg = foreground },
  Boolean                                = { fg = constant_teal },
  Identifier                             = { fg = variable_yellow },
  Function                               = { fg = function_cyan, bold = false },
  Statement                              = { fg = keyword_orange, bold = true },
  Conditional                            = { link = "Statement" },
  Repeat                                 = { link = "Statement" },
  Label                                  = { link = "Statement" },
  Operator                               = { fg = foreground },
  Keyword                                = { fg = keyword_orange, bold = true },
  Exception                              = { link = "Keyword" },
  PreProc                                = { fg = builtin_cyan },
  Include                                = { link = "PreProc" },
  Define                                 = { link = "PreProc" },
  Macro                                  = { link = "PreProc" },
  Type                                   = { fg = type_blue },
  StorageClass                           = { link = "Type" },
  Structure                              = { link = "Type" },
  Typedef                                = { link = "Type" },
  Special                                = { fg = builtin_cyan },
  SpecialChar                            = { link = "Special" },
  Tag                                    = { fg = function_cyan },
  Delimiter                              = { fg = foreground },
  Todo                                   = { fg = warning_red, bold = true },

  DiagnosticError                        = { fg = warning_red },
  DiagnosticWarn                         = { fg = keyword_orange },
  DiagnosticInfo                         = { fg = function_cyan },
  DiagnosticHint                         = { fg = type_blue },
  DiagnosticOk                           = { fg = comment_green },
  DiagnosticUnnecessary                  = { fg = comment_green, italic = true },
  DiagnosticUnderlineError               = { sp = warning_red, undercurl = true },
  DiagnosticUnderlineWarn                = { sp = keyword_orange, undercurl = true },
  DiagnosticUnderlineInfo                = { sp = function_cyan, undercurl = true },
  DiagnosticUnderlineHint                = { sp = type_blue, undercurl = true },

  DiagnosticVirtualTextError             = { fg = warning_red, bg = bg_red_subtle, bold = true },
  DiagnosticVirtualTextWarn              = { fg = keyword_orange, bg = bg_yellow_intense, bold = true },
  DiagnosticVirtualTextInfo              = { fg = function_cyan, bg = bg_blue_subtle, bold = true },
  DiagnosticVirtualTextHint              = { fg = function_cyan, bg = bg_cyan_subtle, bold = true },
  DiagnosticVirtualTextOk                = { fg = comment_green, bg = bg_green_subtle, bold = true },

  SpellBad                               = { sp = warning_red, undercurl = true },
  SpellCap                               = { sp = variable_yellow, undercurl = true },
  SpellLocal                             = { sp = function_cyan, undercurl = true },
  SpellRare                              = { sp = keyword_orange, undercurl = true },

  texDocZone                             = { fg = string_orange },

  DiffAdd                                = { bg = diff_add },
  DiffDelete                             = { fg = diff_remove, bg = diff_remove },
  DiffText                               = { bg = diff_text },
  DiffChange                             = { bg = diff_change },

  GitSignsDelete                         = { fg = red2 },
  GitSignsChange                         = { fg = keyword_orange },
  GitSignsAdd                            = { fg = comment_green },

  NeogitActiveItem                       = { bg = bg_cyan_subtle },

  markdownLinkText                       = { fg = link_blue, underline = true },
  markdownUrl                            = { fg = link_blue, underline = true },
  htmlLink                               = { fg = link_blue, underline = true },
  htmlArg                                = { fg = type_blue },

  RenderMarkdownDash                     = { fg = modeline_inactive_bg, bg = background },
  RenderMarkdownBullet                   = { fg = variable_yellow },

  LspReferenceText                       = { bg = mod(highlight_bg, -30) },
  LspReferenceRead                       = { bg = mod(highlight_bg, -30) },
  LspReferenceWrite                      = { bg = mod(highlight_bg, -30), underline = true },
  LspCodeLens                            = { link = "Comment" },
  LspCodeLensSeparator                   = { link = "Comment" },
  LspInlayHint                           = { fg = modeline_inactive_bg },

  BlinkCmpMenuBorder                     = { link = "FloatBorder" },
  BlinkCmpDocBorder                      = { link = "FloatBorder" },
  BlinkCmpSignatureHelpBorder            = { link = "FloatBorder" },
  BlinkCmpLabelMatch                     = { fg = keyword_orange, bold = true },
  BlinkCmpGhostText                      = { fg = modeline_inactive_bg },

  TelescopeBorder                        = { link = "FloatBorder" },

  FzfLuaBackdrop                         = { bg = background },
  FzfLuaBorder                           = { link = "FloatBorder" },
  FzfLuaLivePrompt                       = { fg = foreground },
  FzfLuaHeaderText                       = { fg = function_cyan },
  FzfLuaHeaderBind                       = { fg = function_cyan },
  FzfLuaBufFlagCur                       = { fg = function_cyan },
  FzfLuaPathLineNr                       = { fg = foreground },
  FzfLuaPathColNr                        = { fg = foreground },
  FzfLuaBufFlagAlt                       = { fg = comment_green },
  FzfLuaBufNr                            = { fg = variable_yellow },
  fzf1                                   = { fg = "bg", bg = "bg" },
  fzf2                                   = { link = "fzf1" },
  fzf3                                   = { link = "fzf1" },
  FzfLuaTitle                            = { link = "fzf1" },
  FzfLuaTitleFlags                       = { link = "fzf1" },
  FzfLuaFzfSeparator                     = { fg = background },
  FzfLuaFzfPointer                       = { fg = variable_yellow },
  FzfLuaFzfPrompt                        = { fg = foreground },
  FzfLuaFzfMatch                         = { link = "PmenuMatch" },

  -- SnacksWinSeparator                     = { fg = background_dark, bg = background_dark },
  SnacksWinSeparator                     = { link = "WinSeparator" },
  SnacksPickerInputBorder                = { fg = modeline_inactive_bg, bg = background_dark },
  SnacksPickerTree                       = { fg = cursor_bg, bg = background_dark },
  SnacksPickerListCursorLine             = { link = "CursorLine" },
  SnacksPickerPrompt                     = { fg = builtin_cyan, bg = background_dark },
  SnacksIndent                           = { fg = mod(modeline_inactive_bg, -40) },
  SnacksIndentScope                      = { fg = mod(modeline_inactive_bg, -20) },
  SnacksImageMath                        = { fg = builtin_cyan },

  DiffviewNormal                         = { link = "NormalFloat" },
  DiffviewWinseparator                   = { link = "SnacksWinSeparator" },
  DiffviewSignColumn                     = { link = "NormalFloat" },

  NeoTreeWinseparator                    = { fg = background_dark, bg = background_dark },

  MiniIndentscopeSymbol                  = { fg = modeline_inactive_bg },
  MiniPickMatchCurrent                   = { link = "PmenuSel" },
  MiniPickMatchMarked                    = { fg = keyword_orange, bold = true },
  MiniPickMatchRanges                    = { fg = keyword_orange, bold = true },
  MiniFilesCursorLine                    = { link = "PmenuSel" },
  MiniFilesBorder                        = { fg = background_dark, bg = background_dark },
  MiniFilesTitle                         = { fg = link_blue, bg = background_dark },
  MiniFilesTitleFocused                  = { fg = link_blue, bg = background_dark },

  MiniClueDescGroup                      = { bg = mod(background, 30) },
  MiniClueDescSingle                     = { bg = mod(background, 30) },
  MiniClueNextKey                        = { bg = region_bg },
  MiniClueNextKeyWithPostkeys            = { bg = region_bg },
  MiniClueSeparator                      = { fg = link_blue, bg = mod(background, 30) },

  TreesitterContext                      = { bg = background, underline = true, sp = cursor_bg },
  TreesitterContextLineNumber            = { bg = background, underline = true, sp = cursor_bg },
  TreesitterContextSeparator             = { fg = modeline_inactive_bg },

  User1                                  = { link = "DiagnosticError" },
  User3                                  = { fg = modeline_fg, bold = true },
  User4                                  = { fg = modeline_fg },
  User5                                  = { fg = "NvimLightCyan" },
  User6                                  = { fg = modeline_fg },
  User8                                  = { link = "DiagnosticWarn" },
  User9                                  = { fg = comment_green },

  ["@attribute"]                         = { fg = variable_yellow },
  ["@constant.builtin"]                  = { link = "Constant" },
  ["@constructor"]                       = { link = "Function" },
  ["@constant.macro"]                    = { link = "Macro" },
  ["@function.builtin"]                  = { fg = function_cyan },
  ["@variable.builtin"]                  = { link = "Keyword" },
  ["@variable.member"]                   = { link = "Identifier" },
  ["@variable.parameter"]                = { link = "Identifier" },
  ["@markup.link"]                       = {},
  ["@markup.link.label.markdown_inline"] = { fg = link_blue, underline = true },
  -- ["@markup.link.label.markdown_inline"] = { fg = link_blue, underline = true },
  ["@markup.raw.markdown_inline"]        = { fg = builtin_cyan, bg = region_bg },
  ["@markup.link.url.markdown_inline"]   = { fg = string_orange, underline = false },
  ["@module"]                            = { link = "Identifier" },
  ["@punctuation.special"]               = { fg = foreground },
  ["@punctuation.special.latex"]         = { fg = function_cyan },
  ["@type.builtin"]                      = { link = "@type" },

  ["@comment"]                           = { link = "Comment" },
  ["@comment.documentation"]             = { fg = comment_green, italic = true },
  ["@comment.error"]                     = { link = "DiagnosticVirtualTextError" },
  ["@comment.warning"]                   = { link = "DiagnosticVirtualTextWarn" },
  ["@comment.todo"]                      = { link = "DiagnosticVirtualTextHint" },
  ["@comment.note"]                      = { link = "DiagnosticVirtualTextHint" },

  ["@markup.heading"]                    = { link = "Title" },
  ["@markup.heading.1"]                  = { fg = type_blue, bold = true },
  ["@markup.heading.2"]                  = { fg = variable_yellow, bold = true },
  ["@markup.heading.3"]                  = { fg = string_orange, bold = true },
  ["@markup.heading.4"]                  = { fg = builtin_cyan, bold = true },
  ["@markup.heading.5"]                  = { fg = warning_red, bold = true },
  ["@markup.heading.6"]                  = { fg = type_blue, bold = true },

  BufferLineOffsetSeparator              = { fg = cursor_bg, bg = background_light },
  BufferLineOffsetHelp                   = { link = "SidebarNormal" },
  BufferLineOffset                       = { link = "SidebarNormal" },
  BufferLineOffsetExplorer               = { bg = background_dark },
  BufferLineFill                         = { link = "TabLineFill" },
  BufferLineModified                     = { fg = mod(variable_yellow, -50), bg = modeline_bg },
  BufferLineModifiedVisible              = { fg = mod(variable_yellow, -30), bg = "#29323d", },
  BufferLineModifiedSelected             = { fg = variable_yellow, bg = background },

}

for group, opts in pairs(highlights) do
  nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "misterioso"
