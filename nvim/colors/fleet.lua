local mod = require("utils").modify_colour

-- reset colors
if vim.g.colors_name then
  vim.cmd.hi("clear")
end

vim.g.colors_name = "fleet"
vim.o.termguicolors = true

local palette = {
  background = "#1A1C1E",
  background_lighter = mod("#1A1C1E", 40),
  background_dark = mod("#1A1C1E", -10),
  background_darker = mod("#1A1C1E", -20),
  darkest = mod("#23262A", 20),
  darker = mod("#1A1C1E", 100),
  dark = "#8E98A3",

  -- light = "#d6d6dd",
  light = "#b5bdc5",
  lightest = "#ffffff",

  dark_gray = "#4F5862",
  light_gray = "#6E7883",
  purple = "#a390f0",
  light_blue = "#7dbeff",
  blue = "#52a7f6",
  -- pink = "#d898d8",
  pink = "#b294bb",
  green = "#afcb85",
  cyan = "#78d0bd",
  orange = "#efb080",
  yellow = "#e5c995",
  red = "#CC7C8A",

  blue_accent = "#2197F3",
  pink_accent = "#E44C7A",
  green_accent = "#00AF99",
  orange_accent = "#EE7F25",
  yellow_accent = "#DEA407",
  red_accent = "#F44747",

  red_error = "#EB5F6A",
  selection = "#2A3F56",
  diff_plus = "#5A9F81",
  focus = "#315A7C",

  error_bg = "#553238",
  warning_bg = "#5A4126",
  info_bg = "#3C424A",
  hint_bg = "#2E455A",

  diff_text = "#3E4752",
  diff_add = "#3F5560",
  diff_change = "#5B5549",
  diff_remove = "#5B474F",
}

vim.g.terminal_color_0 = palette.background
vim.g.terminal_color_1 = palette.yellow
vim.g.terminal_color_2 = palette.yellow
vim.g.terminal_color_3 = palette.yellow
vim.g.terminal_color_4 = palette.blue
vim.g.terminal_color_5 = palette.light
vim.g.terminal_color_6 = palette.cyan
vim.g.terminal_color_7 = palette.light
vim.g.terminal_color_8 = palette.brighterblack
vim.g.terminal_color_9 = palette.red
vim.g.terminal_color_10 = palette.green
vim.g.terminal_color_11 = palette.cyan
vim.g.terminal_color_12 = palette.blue
vim.g.terminal_color_13 = palette.light
vim.g.terminal_color_14 = palette.cyan
vim.g.terminal_color_15 = palette.brightwhite

local groups = {
  Normal                           = { bg = palette.background, fg = palette.light },
  TerminalNormal                   = { bg = palette.background_darker },
  SidebarNormal                    = { bg = palette.background_darker },
  DBUINormal                       = { link = "NormalFloat" },
  Comment                          = { fg = palette.light_gray, italic = true },
  ColorColumn                      = { bg = palette.background_darker },
  Conceal                          = { fg = palette.yellow },
  Cursor                           = { bg = palette.light, fg = palette.dark_gray },
  CursorLine                       = { bg = palette.background_lighter },
  Directory                        = { fg = palette.cyan },
  DiffAdd                          = { bg = palette.diff_add },
  DiffDelete                       = { fg = palette.red, bg = palette.diff_remove },
  DiffText                         = { bg = palette.diff_text },
  DiffChange                       = { bg = palette.diff_change },
  diffAdded                        = { link = "DiffAdd" },
  diffRemoved                      = { link = "DiffDelete" },
  diffChanged                      = { link = "DiffChange" },
  NeogitActiveItem                 = { bg = palette.diff_text },
  EndOfBuffer                      = { fg = palette.background, bold = true },
  -- TermCursor   = { },
  -- TermCursorNC = { },
  ErrorMsg                         = { fg = palette.red_error, underline = true },
  VertSplit                        = { bg = palette.background, fg = palette.darker },
  WinSeparator                     = { fg = palette.darker },
  FloatBorder                      = { fg = palette.light_gray },
  Folded                           = { bg = palette.darker, fg = palette.light_gray },
  -- FoldColumn   = { },
  SignColumn                       = { bg = palette.background, fg = palette.dark_gray },
  -- IncSearch    = { },
  -- Substitute   = { },
  LineNr                           = { fg = palette.dark_gray, bg = mod(palette.background, 0) },
  CursorLineNr                     = { bg = palette.background_lighter, fg = palette.light, bold = true },
  CursorLineSign                   = { bg = palette.background_lighter },
  MatchParen                       = { bg = palette.darker },
  -- ModeMsg      = { },
  -- MsgArea      = { },
  -- MsgSeparator = { },
  -- MoreMsg      = { },
  NonText                          = { fg = palette.darker },
  NormalFloat                      = { bg = palette.background_darker },
  -- NormalNC     = { },
  Pmenu                            = { bg = palette.darkest, fg = palette.light },
  PmenuSel                         = { bg = palette.selection, fg = palette.light, bold = true },
  PmenuSbar                        = { bg = palette.darker, fg = palette.light, bold = true },
  PmenuThumb                       = { bg = palette.light_gray, fg = palette.light, bold = true },
  PmenuBorder                      = { link = "FloatBorder" },
  -- Question     = { },
  -- Search                           = { fg = palette.light, bg = palette.selection, bold = true },
  QuickFixLine                     = { fg = palette.yellow },
  -- QuickFixLine = { bg = Normal.bg.mix(Search.bg, 40)  },
  SpecialKey                       = { link = "Directory" },
  -- SpellBad     = { },
  -- SpellCap     = { },
  -- SpellLocal   = { },
  -- SpellRare    = { },
  -- StatusLine                       = { bg = palette.darker, fg = palette.dark },
  -- StatusLineNC                     = { bg = palette.darker, fg = palette.dark },
  StatusLine                       = { bg = palette.background_darker, fg = palette.dark },
  StatusLineNC                     = { bg = palette.background_darker, fg = palette.dark },

  TabLine                          = { bg = palette.background_darker, fg = palette.dark },
  TabLineFill                      = { link = "TabLine" },
  TabLineSel                       = { bg = palette.dark_gray, fg = palette.lightest },

  Title                            = { fg = palette.green, bold = true },
  Visual                           = { bg = palette.selection },
  -- VisualNOS    = { },
  VisualNonText                    = { fg = mod(palette.light_gray, -20), bg = palette.selection },
  WarningMsg                       = { fg = palette.yellow_accent },
  Whitespace                       = { link = "Comment" },
  WildMenu                         = { bg = palette.darker },

  -- These groups are not listed as default vim groups,
  -- but they are defacto standard group names for syntax highlighting.
  -- commented out groups should chain up to their "preferred" group by
  -- default,
  -- Uncomment and edit if you want more specific syntax highlighting.

  Constant                         = { fg = palette.purple },
  String                           = { fg = palette.pink },
  Character                        = { fg = palette.yellow },
  Number                           = { fg = palette.yellow },
  Boolean                          = { fg = palette.yellow },
  Float                            = { fg = palette.yellow },

  Identifier                       = { fg = palette.light },
  Function                         = { fg = palette.yellow },

  Keyword                          = { fg = palette.cyan },
  Statement                        = { link = "Keyword" },
  Conditional                      = { link = "Keyword" },
  Repeat                           = { link = "Keyword" },
  Label                            = { link = "Keyword" },
  Operator                         = { fg = palette.light },
  Exception                        = { link = "Keyword" },

  PreProc                          = { link = "Keyword" },
  Include                          = { link = "Keyword" },
  Define                           = { link = "Keyword" },
  Macro                            = { fg = palette.green, bold = true },
  PreCondit                        = { link = "Keyword" },

  Type                             = { fg = palette.light_blue },
  -- StorageClass   = { fg = "#A1B56C" },
  Structure                        = { link = "Type" },
  Typedef                          = { link = "Type" },

  Special                          = { fg = palette.light },
  SpecialChar                      = { fg = palette.yellow },
  -- Tag            = { },
  Delimiter                        = { fg = palette.light },
  -- SpecialComment = { },
  -- Debug          = { },

  Underlined                       = { fg = palette.yellow, underline = true },
  -- Bold       = { bold = true },
  -- Italic     = { italic = true },

  -- ("Ignore", below, may be invisible...)
  -- Ignore         = { },

  Error                            = { bg = palette.red_error, fg = palette.darker },

  Todo                             = { bg = palette.focus, fg = palette.light, bold = true },

  DiagnosticError                  = { fg = palette.red_error },
  DiagnosticWarn                   = { fg = palette.orange_accent },
  DiagnosticInfo                   = { fg = palette.light },
  DiagnosticHint                   = { fg = palette.blue },
  -- DiagnosticVirtualTextError = { },
  -- DiagnosticVirtualTextWarn  = { },
  -- DiagnosticVirtualTextInfo  = { },
  -- DiagnosticVirtualTextHint  = { },
  DiagnosticUnderlineError         = { sp = palette.red_error, undercurl = true },
  DiagnosticUnderlineWarn          = { sp = palette.orange_accent, undercurl = true },
  DiagnosticUnderlineInfo          = { sp = palette.light, undercurl = true },
  DiagnosticUnderlineHint          = { sp = palette.blue, undercurl = true },
  -- DiagnosticFloatingError    = { },
  -- DiagnosticFloatingWarn     = { },
  -- DiagnosticFloatingInfo     = { },
  -- DiagnosticFloatingHint     = { },
  -- DiagnosticSignError        = { },
  -- DiagnosticSignWarn         = { },
  -- DiagnosticSignInfo         = { },
  -- DiagnosticSignHint         = { },

  LspInlayHint                     = { fg = palette.light_gray },

  -- These groups are for tree-sitter:

  ["@attribute"]                   = { fg = palette.green },
  -- ["@boolean"]            = { },
  -- ["@character"]          = { },
  -- ["@comment"]            = { },
  -- ["@conditional"]        = { },
  -- ["@constant"]           = { },
  ["@constant.builtin"]            = { link = "Type" },
  -- ["@constant.macro"]         = { },
  ["@constructor"]                 = { fg = palette.yellow },
  -- ["@error"]              = { },
  ["@exception"]                   = { fg = palette.purple },
  -- ["@field"]              = { },
  -- ["@float"]              = { },
  ["@function"]                    = { link = "Function" },
  ["@function.builtin"]            = { fg = palette.green },
  ["@function.macro"]              = { fg = palette.green },
  -- ["@include"]            = { },
  ["@keyword"]                     = { fg = palette.cyan },
  -- ["@keyword.function"]    = { },
  -- ["@keyword.operator"]    = { },
  -- ["@keyword.return"]      = { },
  ["@label"]                       = { fg = palette.yellow },
  -- ["@method"]             = { },
  ["@namespace"]                   = { fg = palette.green },
  -- ["@none"]               = { },
  -- ["@number"]             = { },
  -- ["@operator"]           = { },
  -- ["@parameter"]          = { },
  -- ["@parameter.reference"] = { },
  -- ["@property"]           = { },
  ["@punctuation.delimiter"]       = { fg = palette.light },
  ["@punctuation.bracket"]         = { fg = palette.light },
  ["@punctuation.special"]         = { fg = palette.light },
  -- ["@repeat"]             = { },
  ["@string"]                      = { fg = palette.pink },
  -- ["@string.regex"]        = { },
  -- ["@string.escape"]       = { },
  ["@string.special"]              = { fg = palette.cyan },
  -- ["@symbol"]             = { },
  ["@tag"]                         = { fg = palette.light_blue },
  ["@tag.attribute"]               = { fg = palette.purple },
  ["@tag.delimiter"]               = { fg = palette.light_gray },
  -- ["@text"]               = { },
  -- ["@strong"]             = { },
  -- ["@emphasis"]           = { },
  -- ["@underline"]          = { },
  -- ["@strike"]             = { },
  -- ["@title"]              = { },
  -- ["@literal"]            = { },
  -- ["@uri"]                = { },
  -- ["@math"]               = { },
  -- ["@text.reference"]      = { },
  -- ["@environment"]        = { },
  -- ["@environment.name"]    = { },
  -- ["@note"]               = { },
  -- ["@warning"]            = { },
  ["@danger"]                      = { fg = palette.red_error },
  ["@type"]                        = { fg = palette.light_blue },
  ["@type.builtin"]                = { fg = palette.cyan },
  ["@variable"]                    = { fg = palette.light },
  ["@variable.builtin"]            = { link = "Identifier" },

  -- ["@markup.link"]                 = { fg = palette.blue, underline = true },
  -- ["@markup.heading.1"]            = { fg = palette.blue, bold = true },
  -- ["@markup.heading.2"]            = { fg = palette.blue, bold = true },
  -- ["@markup.heading.3"]            = { fg = palette.blue, bold = true },
  -- ["@markup.heading.4"]            = { fg = palette.blue, bold = true },
  -- ["@markup.heading.5"]            = { fg = palette.blue, bold = true },
  -- ["@markup.heading.6"]            = { fg = palette.blue, bold = true },

  ["@markup.raw.markdown_inline"]  = { fg = palette.light, bg = palette.darker },
  ["@markup.list.markdown"]        = { fg = palette.cyan },
  ["@markup.quote.markdown"]       = { fg = palette.purple },

  Scrollbar                        = { fg = palette.darker },
  ScrollbarThumb                   = { fg = palette.light_gray },

  BlinkCmpMenuBorder               = { link = "FloatBorder" },
  BlinkCmpDocBorder                = { link = "FloatBorder" },
  BlinkCmpSignatureHelpBorder      = { link = "FloatBorder" },
  BlinkCmpLabelMatch               = { link = "PmenuMatch" },
  BlinkCmpGhostText                = { fg = palette.light_gray },

  FzfLuaBorder                     = { link = "FloatBorder" },
  FzfLuaBackDrop                   = { bg = palette.background },
  FzfLuaTitle                      = { fg = "bg", bg = "bg" },
  FzfLuaTitleFlags                 = { fg = "bg", bg = "bg" },
  FzfLuaLivePrompt                 = { fg = "fg" },
  FzfLuaFzfSeparator               = { fg = palette.background },
  FzfLuaFzfMatch                   = { link = "PmenuMatch" },
  fzf1                             = { fg = "bg", bg = "bg" },
  fzf2                             = { fg = "bg", bg = "bg" },
  fzf3                             = { fg = "bg", bg = "bg" },
  TreeSitterContext                = { bg = palette.background, underline = true, sp = palette.darker },
  TreeSitterContextLineNumber      = { fg = palette.lightest, underline = true, sp = palette.darker },
  User1                            = { link = "DiagnosticError" },
  User3                            = { fg = palette.cyan, bold = true },
  User5                            = { fg = palette.lightest, bold = true },
  User9                            = { fg = palette.green_accent },

  -- SnacksWinseparator               = { fg = palette.background_darker, bg = palette.background_darker },
  SnacksPickerGitStatusUntracked   = { fg = palette.light },
  SnacksPickerInputBorder          = { fg = palette.dark_gray, bg = palette.background_darker },
  SnacksPickerBorder               = { fg = palette.background_darker, bg = palette.background_darker },
  SnacksPickerInputTitle           = { fg = palette.blue, bg = palette.background_darker },
  SnacksIndent                     = { fg = mod(palette.light_gray, -50) },
  SnacksIndentScope                = { fg = mod(palette.light_gray, -20) },
  SnacksPickerTree                 = { fg = mod(palette.light_gray, -50), bg = palette.background_darker },

  BufferLineOffsetSeparator        = { fg = palette.darker, bg = palette.background },
  BufferLineFill                   = { link = "TabLineFill" },
  BufferLineModified               = { fg = palette.dark_gray, bg = "#131516" },
  BufferLineModifiedVisible        = { fg = palette.dark_gray, bg = "#17191b" },
  BufferLineModifiedSelected       = { fg = palette.dark_gray, bg = palette.background },
  BufferLineOffsetHelp             = { fg = palette.foreground, bg = palette.backgrounder, underline = false, sp = mod(palette.darker, 60) },
  BufferLineOffset                 = { fg = palette.fgreground, bg = palette.background_darker },
  BufferLineOffsetExplorer         = { fg = palette.fgreground, bg = palette.background_darker, underline = false, sp = mod(palette.darker, 60) },

  DiffviewNormal                   = { bg = palette.background_darker },

  GitSignsCurrentLineBlame         = { fg = palette.light_gray },

  MiniCompletionInfoBorderOutdated = { fg = palette.orange_accent, bg = palette.background },
}

local overrides = vim.g.fleet_theme_overrides or {}
for group, hl in pairs(overrides) do
  if groups[group] then
    -- "link" should not mix with other configs (:h hi-link)
    groups[group].link = nil
  end

  groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
end

for group, settings in pairs(groups) do
  vim.api.nvim_set_hl(0, group, settings)
end
