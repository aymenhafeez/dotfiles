vim.cmd("highlight clear")

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "default_custom"

local mod = require("utils").modify_colour

local c = {
  bg = "#1a1c1f",
  fg = "#c5c8c6",
  purple = "#b29abb",
  green = "#b8c078",
  orange = "#e4945c",
  blue = "#8fa9bc",
  yellow = "#e1c281",
  cyan = "#99b2ad",
  red = "#ca7675",
  comment = "#696969",
  bg_light = mod("#1a1c1f", 30),
  bg_light2 = mod("#1a1c1f", 150),
  fg_dark = "#959896",
  fg_dark2 = "#858886",
  bg_dark = mod("#1a1c1f", -25),

  diff_add = "#494d3a",
  diff_remove = "#3d2e30",
  diff_change = "#3a3c3e",
  diff_text = "#434d56",
  green_bg = "#2a2c28",
  cyan_bg = "#272b2d",
  orange_bg = "#2e2825",
  red_bg = "#2c2528",
  cyan_muted = "#3a4243",
}

vim.g.terminal_color_0 = c.comment
vim.g.terminal_color_1 = c.fg
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.yellow
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.fg
vim.g.terminal_color_6 = c.cyan
vim.g.terminal_color_7 = c.fg
vim.g.terminal_color_8 = c.fg_dark2
vim.g.terminal_color_9 = c.yellow
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.red
vim.g.terminal_color_12 = c.blue
vim.g.terminal_color_13 = c.purple
vim.g.terminal_color_14 = c.cyan
vim.g.terminal_color_15 = c.fg

local hl = {
  Conceal                         = { fg = c.comment },
  CurSearch                       = { fg = c.bg, bg = c.orange },
  Cursor                          = { fg = c.bg, bg = c.fg, blink = true },
  CursorColumn                    = { bg = c.bg },
  CursorLine                      = { bg = mod(c.bg_light, -10) },
  CursorLineNr                    = { fg = c.fg, bg = c.bg },
  ColorColumn                     = { bg = mod(c.bg, 70) },
  DiffAdd                         = { bg = c.diff_add },
  DiffChange                      = { bg = c.diff_change },
  DiffDelete                      = { fg = c.red, bg = c.diff_remove },
  DiffText                        = { bg = c.diff_text },
  Directory                       = { fg = c.blue },
  EndOfBuffer                     = { fg = c.bg },
  ErrorMsg                        = { fg = c.red, bold = true },
  FloatBorder                     = { fg = mod(c.fg_dark2, -40), bg = c.bg_dark },
  FoldColumn                      = { fg = c.fg_dark },
  Folded                          = { fg = c.fg_dark, bg = c.bg_light },
  LineNr                          = { fg = c.comment, bg = c.bg },
  MatchParen                      = { fg = c.orange, bg = c.comment, bold = true },
  ModeMsg                         = { fg = c.fg_dark },
  MoreMsg                         = { fg = c.purple },
  NonText                         = { fg = c.fg_dark },
  Normal                          = { fg = c.fg, bg = c.bg },
  NormalFloat                     = { fg = c.fg, bg = c.bg_dark },
  Pmenu                           = { fg = c.fg_dark, bg = mod(c.bg_light, 20) },
  PmenuMatch                      = { fg = c.cyan, bold = true },
  PmenuMatchSel                   = { fg = c.cyan, bold = true },
  PmenuSbar                       = { bg = c.bg_light2 },
  PmenuSel                        = { fg = c.cyan, bg = c.bg_light2 },
  PmenuThumb                      = { fg = c.fg_dark2, bg = c.fg_dark2 },
  Question                        = { fg = c.yellow },
  QuickFixLine                    = { link = "TerminalNormal" },
  Search                          = { fg = c.bg, bg = c.yellow },
  SignColumn                      = { bg = c.bg },
  SpecialKey                      = { fg = c.fg_dark },
  SpellBad                        = { sp = c.red, undercurl = true },
  SpellCap                        = { sp = c.fg_dark, undercurl = true },
  SpellLocal                      = { sp = c.fg_dark, undercurl = true },
  SpellRare                       = { sp = c.purple, undercurl = true },
  StatusLine                      = { fg = c.fg, bg = mod(c.bg_light, 50) },
  StatusLineNC                    = { fg = c.fg_dark2, bg = mod(c.bg_light, 30) },
  Substitute                      = { link = "CurSearch" },
  TabLine                         = { fg = c.comment, bg = c.bg_dark },
  TabLineFill                     = { bg = c.bg_dark },
  TabLineSel                      = { fg = c.fg, bg = c.bg_dark, bold = true },
  TerminalNormal                  = { bg = c.bg_dark },
  SidebarNormal                   = { link = "NormalFloat" },
  DBUINormal                      = { link = "TerminalNormal" },
  DBUIOutNormal                   = { link = "TerminalNormal" },
  TermCursor                      = { link = "Cursor" },
  Title                           = { fg = c.blue, bold = true },
  Visual                          = { bg = c.bg_light2 },
  VisualNonText                   = { bg = c.bg_light2, fg = c.comment },
  WarningMsg                      = { fg = c.orange, bold = true },
  Whitespace                      = { fg = c.fg_dark2 },
  WildMenu                        = { link = "CurSearch" },
  WinBar                          = { link = "StatusLine" },
  WinBarNC                        = { link = "StatusLineNC" },
  WinSeparator                    = { fg = mod(c.fg_dark2, -30), bg = c.bg },
  lCursor                         = { link = "Cursor" },

  Added                           = { fg = c.green },
  Changed                         = { fg = c.blue },
  Character                       = { fg = c.green },
  Comment                         = { fg = c.comment, italic = true },
  Constant                        = { fg = c.orange },
  Debug                           = { fg = c.orange },
  Delimiter                       = { fg = c.fg_dark2 },
  Error                           = { fg = c.red },
  Exception                       = { fg = c.red },
  Function                        = { fg = c.blue },
  Identifier                      = { fg = c.fg },
  Ignore                          = { fg = c.fg_dark },
  Label                           = { fg = c.blue },
  Macro                           = { fg = c.orange },
  Operator                        = { fg = c.fg },
  PreCondit                       = { fg = c.yellow },
  PreProc                         = { fg = c.purple },
  Removed                         = { fg = c.red },
  Special                         = { fg = c.red, bold = true },
  SpecialChar                     = { fg = c.red },
  SpecialComment                  = { link = "Comment" },
  Statement                       = { fg = c.purple },
  StorageClass                    = { fg = c.red },
  String                          = { fg = c.green },
  Tag                             = { fg = c.red },
  Todo                            = { fg = c.orange, bold = true },
  Type                            = { fg = c.yellow },

  LspSignatureActiveParameter     = { underline = true, bold = true },

  DiagnosticOk                    = { fg = c.green },
  DiagnosticHint                  = { fg = c.cyan },
  DiagnosticInfo                  = { fg = c.cyan },
  DiagnosticWarn                  = { fg = c.orange },
  DiagnosticError                 = { fg = c.red },
  DiagnosticUnnecessary           = {},
  DiagnosticUnderlineOk           = { sp = c.green, undercurl = true },
  DiagnosticUnderlineHint         = { sp = c.cyan, undercurl = true },
  DiagnosticUnderlineInfo         = { sp = c.cyan, undercurl = true },
  DiagnosticUnderlineWarn         = { sp = c.orange, undercurl = true },
  DiagnosticUnderlineError        = { sp = c.red, undercurl = true },

  DiagnosticVirtualTextOk         = { fg = c.green, bg = c.green_bg },
  DiagnosticVirtualTextHint       = { fg = c.cyan, bg = c.cyan_bg },
  DiagnosticVirtualTextInfo       = { fg = c.cyan, bg = c.cyan_bg },
  DiagnosticVirtualTextWarn       = { fg = c.orange, bg = c.orange_bg },
  DiagnosticVirtualTextError      = { fg = c.red, bg = c.red_bg },

  SnacksImageMath                 = { fg = c.blue },
  SnacksPickerTree                = { fg = c.comment, bg = c.bg_dark },

  Scrollbar                       = { fg = mod(c.bg, 80) },
  ScrollbarThumb                  = { fg = mod(c.bg, 230) },

  RenderMarkdownDash              = { fg = mod(c.fg_dark2, -40), bg = c.bg },
  RenderMarkdownBullet            = { fg = c.yellow },
  RenderMarkdownMath              = { fg = c.cyan, bg = c.bg_light },
  RenderMarkdownH1Bg              = { link = "DiagnosticVirtualTextInfo" },
  RenderMarkdownH2Bg              = { link = "DiagnosticVirtualTextWarn" },
  RenderMarkdownH3Bg              = { link = "DiagnosticVirtualTextOk" },
  RenderMarkdownH4Bg              = { link = "DiagnosticVirtualTextError" },
  RenderMarkdownH5Bg              = { link = "DiagnosticVirtualTextHint" },

  BlinkCmpLabelMatch              = { link = "PmenuMatchSel" },

  TreeSitterContext               = { bg = c.bg },

  GitSignsCurrentLineBlame        = { fg = c.comment },
  NeogitActiveItem                = { bg = c.cyan_muted },
  NeogitGraphPurple               = { fg = c.cyan },
  NeogitHunkHeaderCursor          = { bg = c.fg },
  NeogitHunkHeaderHighlight       = { bg = c.fg },

  ["@variable"]                   = { fg = c.fg },
  ["@variable.builtin"]           = { fg = c.red },
  ["@variable.parameter.builtin"] = { fg = c.red },
  ["@variable.member"]            = { fg = c.orange },
  ["@variable.member.python"]     = { fg = c.fg },
  ["@variable.member.lua"]        = { fg = c.fg },
  ["@constant.builtin"]           = { link = "@constant" },
  ["@module"]                     = { fg = mod(c.fg, -10) },
  ["@module.latex"]               = { fg = c.cyan },
  ["@module.builtin"]             = { fg = c.red },
  ["@string.special.url"]         = { fg = c.cyan, underline = true },
  ["@type.builtin"]               = { fg = c.orange },
  ["@attribute"]                  = { link = "PreProc" },
  ["@function.builtin"]           = { fg = c.red },
  ["@function.macro"]             = { link = "Macro" },
  ["@constructor"]                = { fg = c.yellow },
  ["@keyword.coroutine"]          = { fg = c.red },
  ["@keyword.modifier"]           = { fg = c.red },
  ["@keyword.directive"]          = { fg = c.red },
  ["@keyword.directive.markdown"] = { fg = c.green },
  ["@punctuation"]                = { link = "Delimiter" },
  ["@punctuation.special"]        = { fg = c.red },
  ["@punctuation.special.latex"]  = { fg = c.orange },
  ["@comment.error"]              = { link = "DiagnosticVirtualTextError" },
  ["@comment.warning"]            = { link = "DiagnosticVirtualTextWarn" },
  ["@comment.todo"]               = { link = "DiagnosticVirtualTextHint" },
  ["@comment.note"]               = { link = "DiagnosticVirtualTextHint" },
  ["@markup.quote"]               = { fg = c.fg },
  ["@markup.math"]                = { fg = c.cyan },
  ["@markup.link"]                = { fg = c.blue },
  ["@markup.link.label"]          = { fg = c.orange },
  ["@markup.link.url"]            = { underline = true },
  ["@markup.raw"]                 = { link = "String" },
  ["@markup.list"]                = { link = "Special" },
  ["@markup.list.checked"]        = { fg = c.yellow, bold = true },
  ["@markup.list.unchecked"]      = { fg = c.fg_dark, bold = true },
}

for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end
