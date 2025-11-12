-- ~/.config/nvim/colors/coloursceme_3.lua
require("colorbuddy").colorscheme "colourscheme_3"

local colorbuddy = require "colorbuddy"
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Dark palette (exact copy of the JSON)
Color.new("darkStep1", "#0a0a0a")
Color.new("darkStep2", "#141414")
Color.new("darkStep3", "#1e1e1e")
Color.new("darkStep4", "#282828")
Color.new("darkStep5", "#323232")
Color.new("darkStep6", "#3c3c3c")
Color.new("darkStep7", "#484848")
Color.new("darkStep8", "#606060")
Color.new("darkStep9", "#fab283")
Color.new("darkStep10", "#ffc09f")
Color.new("darkStep11", "#808080")
Color.new("darkStep12", "#eeeeee")
Color.new("darkSecondary", "#5c9cf5")
Color.new("darkAccent", "#9d7cd8")
Color.new("darkRed", "#e06c75")
Color.new("darkOrange", "#f5a742")
Color.new("darkGreen", "#7fd88f")
Color.new("darkCyan", "#56b6c2")
Color.new("darkYellow", "#e5c07b")
Color.new("tex_special", "#d16969")

Color.new("diffAdded", "#4fd6be")
Color.new("diffRemoved", "#c53b53")
Color.new("diffContext", "#828bb8")
Color.new("diffHunkHeader", "#828bb8")
Color.new("diffHighlightAdded", "#b8db87")
Color.new("diffHighlightRemoved", "#e26a75")
Color.new("diffAddedBg", "#20303b")
Color.new("diffRemovedBg", "#37222c")
Color.new("diffContextBg", "#141414")
Color.new("diffLineNumber", "#1e1e1e")
Color.new("diffAddedLineNumberBg", "#1b2b34")
Color.new("diffRemovedLineNumberBg", "#2d1f26")

-- --------------------------------------------------------------------
-- Editor basics
-- --------------------------------------------------------------------
Group.new("Normal", c.darkStep12, c.darkStep1)
Group.new("NormalFloat", c.darkStep12, c.darkStep1)
Group.new("FloatBorder", c.darkStep7, c.darkStep2)
Group.new("ColorColumn", nil, c.darkStep3)
Group.new("Cursor", c.darkStep1, c.darkStep12)
Group.new("CursorLine", nil, c.darkStep3)
Group.new("CursorLineNr", c.darkStep9, nil, s.bold)
Group.new("LineNr", c.darkStep11, nil)
Group.new("SignColumn", nil, c.darkStep1)
Group.new("Conceal", c.darkStep11, nil)
Group.new("Visual", nil, c.darkStep8, s.none)
Group.new("Search", c.darkStep1, c.darkOrange)
Group.new("IncSearch", c.darkStep1, c.darkAccent)
Group.new("MatchParen", c.darkAccent, nil, s.bold)
Group.new("NonText", c.darkStep6, nil)
Group.new("Whitespace", c.darkStep6, nil)
Group.new("EndOfBuffer", c.darkStep1, nil)
Group.new("ModeMsg", c.diffContext, nil)

-- --------------------------------------------------------------------
-- Pmenu
-- --------------------------------------------------------------------
Group.new("Pmenu", c.darkStep12, c.darkStep2)
Group.new("PmenuSel", c.darkStep1, c.darkStep9)
Group.new("PmenuSbar", nil, c.darkStep3)
Group.new("PmenuThumb", nil, c.darkStep8)

-- --------------------------------------------------------------------
-- Status/Tabline
-- --------------------------------------------------------------------
Group.new("StatusLine", c.darkStep8, c.darkStep2)
Group.new("StatusLineNC", c.darkStep11, c.darkStep2)
Group.new("StatusLineTerm", c.diffContext, c.darkStep2)
Group.new("TabLine", c.darkStep11, c.darkStep2)
Group.new("TabLineFill", nil, c.darkStep2)
Group.new("TabLineSel", c.darkStep12, c.darkStep3, s.bold)

-- --------------------------------------------------------------------
-- Window separators
-- --------------------------------------------------------------------
Group.new("VertSplit", c.darkStep7, nil)
Group.new("WinSeparator", c.darkStep7, nil)

-- --------------------------------------------------------------------
-- Syntax
-- --------------------------------------------------------------------
Group.new("Comment", c.darkStep11, nil, s.italic)
Group.new("Constant", c.darkGreen, nil)
Group.new("String", c.darkGreen, nil)
Group.new("Character", c.darkGreen, nil)
Group.new("Number", c.darkOrange, nil)
Group.new("Boolean", c.darkOrange, nil)
Group.new("Float", c.darkOrange, nil)
Group.new("Identifier", c.darkRed, nil)
Group.new("Function", c.darkStep9, nil)
Group.new("Statement", c.darkAccent, nil)
Group.new("Conditional", c.darkAccent, nil)
Group.new("Repeat", c.darkAccent, nil)
Group.new("Label", c.darkAccent, nil)
Group.new("Operator", c.darkCyan, nil)
Group.new("Keyword", c.darkAccent, nil)
Group.new("Exception", c.darkAccent, nil)
Group.new("PreProc", c.darkAccent, nil)
Group.new("Include", c.darkAccent, nil)
Group.new("Define", c.darkAccent, nil)
Group.new("Macro", c.darkStep9, nil)
Group.new("PreCondit", c.darkAccent, nil)
Group.new("Type", c.darkYellow, nil)
Group.new("StorageClass", c.darkAccent, nil)
Group.new("Structure", c.darkYellow, nil)
Group.new("Typedef", c.darkYellow, nil)
Group.new("Special", c.darkAccent, nil)
Group.new("SpecialChar", c.darkAccent, nil)
Group.new("Tag", c.darkStep9, nil)
Group.new("Delimiter", c.darkStep12, nil)
Group.new("SpecialComment", c.darkStep11, nil, s.italic)
Group.new("Debug", c.darkOrange, nil)
Group.new("Underlined", nil, nil, s.underline)
Group.new("Ignore", c.darkStep11, nil)
Group.new("Error", c.darkRed, nil)
Group.new("Todo", c.darkStep1, c.darkOrange, s.bold)

-- --------------------------------------------------------------------
-- Diff
-- --------------------------------------------------------------------
Group.new("DiffAdd", c.diffAdded, c.diffAddedBg)
Group.new("DiffDelete", c.diffRemoved, c.diffRemovedBg)
Group.new("DiffChange", c.diffContext, c.diffContextBg)
Group.new("DiffText", c.diffHighlightAdded, c.diffAddedBg)
Group.new("diffAdded", c.diffAdded, nil)
Group.new("diffRemoved", c.diffRemoved, nil)
Group.new("diffChanged", c.darkOrange, nil)
Group.new("diffOldFile", c.diffRemoved, nil)
Group.new("diffNewFile", c.diffAdded, nil)
Group.new("diffFile", c.darkStep9, nil)
Group.new("diffLine", c.darkStep11, nil)
Group.new("diffIndexLine", c.darkStep11, nil)

-- --------------------------------------------------------------------
-- GitSigns
-- --------------------------------------------------------------------
Group.new("GitSignsAdd", c.darkGreen, c.darkStep1)
Group.new("GitSignsChange", c.darkOrange, c.darkStep1)
Group.new("GitSignsDelete", c.darkRed, c.darkStep1)

-- --------------------------------------------------------------------
-- Treesitter
-- --------------------------------------------------------------------
Group.new("@variable", g.Normal, nil)
Group.new("@variable.builtin", c.darkRed, nil)
Group.new("@variable.member", c.darkStep9, nil)
Group.new("@property", c.darkRed, nil)
Group.new("@function", g.Function, nil)
Group.new("@function.builtin", c.darkRed, nil)
Group.new("@function.macro", c.darkStep9, nil)
Group.new("@function.method.call", c.darkStep9, nil)
Group.new("@parameter", c.darkRed, nil)
Group.new("@keyword", g.Keyword, nil)
Group.new("@keyword.operator", g.Operator, nil)
Group.new("@keyword.return", c.darkAccent, nil)
Group.new("@conditional", g.Conditional, nil)
Group.new("@repeat", g.Repeat, nil)
Group.new("@label", g.Label, nil)
Group.new("@include", g.Include, nil)
Group.new("@exception", g.Exception, nil)
Group.new("@type", g.Type, nil)
Group.new("@type.builtin", c.darkYellow, nil)
Group.new("@constructor", c.darkStep9, nil)
Group.new("@operator", g.Operator, nil)
Group.new("@punctuation.delimiter", g.Delimiter, nil)
Group.new("@punctuation.bracket", c.darkStep12, nil)
Group.new("@string", g.String, nil)
Group.new("@string.escape", c.darkAccent, nil)
Group.new("@string.documentation", c.darkStep10, nil)
Group.new("@character", g.Character, nil)
Group.new("@number", g.Number, nil)
Group.new("@boolean", g.Boolean, nil)
Group.new("@float", g.Float, nil)
Group.new("@constant", c.darkGreen, nil)
Group.new("@constant.builtin", c.darkAccent, nil)
Group.new("@constant.macro", c.darkAccent, nil)
Group.new("@namespace", c.darkYellow, nil)
Group.new("@symbol", c.darkStep9, nil)
Group.new("@text", c.darkStep12, nil)
Group.new("@text.strong", nil, nil, s.bold)
Group.new("@text.emphasis", nil, nil)
Group.new("@text.underline", nil, nil, s.underline)
Group.new("@text.title", c.darkAccent, nil, s.bold)
Group.new("@text.literal", c.darkGreen, nil)
Group.new("@text.uri", c.darkStep9, nil, s.underline)
Group.new("@tag", c.darkStep9, nil)
Group.new("@tag.attribute", c.darkRed, nil)
Group.new("@tag.delimiter", c.darkStep11, nil)
Group.new("@module", c.darkOrange, nil)

Group.new("@lsp.type.property", c.darkRed, nil, s.none)
-- Group.new("@lsp.type.property.lua", c.darkSecondary:light(), nil, s.none)
Group.new("@lsp.type.method", c.darkStep9, nil, s.none)

-- --------------------------------------------------------------------
-- LSP
-- --------------------------------------------------------------------
Group.new("LspDiagnosticsDefaultError", c.darkRed, nil)
Group.new("LspDiagnosticsDefaultWarning", c.darkOrange, nil)
Group.new("LspDiagnosticsDefaultInformation", c.darkCyan, nil)
Group.new("LspDiagnosticsDefaultHint", c.darkStep11, nil)
Group.new("LspDiagnosticsUnderlineError", nil, nil, s.undercurl, c.darkRed)
Group.new("LspDiagnosticsUnderlineWarning", nil, nil, s.undercurl, c.darkOrange)
Group.new("LspDiagnosticsUnderlineInformation", nil, nil, s.undercurl, c.darkCyan)
Group.new("LspDiagnosticsUnderlineHint", nil, nil, s.undercurl, c.darkStep11)
Group.new("LspReferenceText", nil, c.darkStep3)
Group.new("LspReferenceRead", nil, c.darkStep3)
Group.new("LspReferenceWrite", nil, c.darkStep3)

-- --------------------------------------------------------------------
-- Markdown
-- --------------------------------------------------------------------
Group.new("markdownHeadingDelimiter", c.darkAccent, nil, s.bold)
Group.new("markdownH1", g.markdownHeadingDelimiter, nil)
Group.new("markdownH2", g.markdownHeadingDelimiter, nil)
Group.new("markdownH3", g.markdownHeadingDelimiter, nil)
Group.new("markdownH4", g.markdownHeadingDelimiter, nil)
Group.new("markdownH5", g.markdownHeadingDelimiter, nil)
Group.new("markdownH6", g.markdownHeadingDelimiter, nil)
Group.new("markdownLinkText", c.darkCyan, nil, s.underline)
Group.new("markdownUrl", c.darkStep9, nil, s.underline)
Group.new("markdownCode", c.darkGreen, nil)
Group.new("markdownCodeBlock", c.darkStep12, nil)
Group.new("markdownBlockquote", c.darkYellow, nil)
Group.new("markdownListMarker", c.darkCyan, nil)
Group.new("markdownOrderedListMarker", c.darkCyan, nil)
Group.new("markdownRule", c.darkStep11, nil)
Group.new("markdownItalic", nil, nil, s.italic)
Group.new("markdownBold", nil, nil, s.bold)

-- --------------------------------------------------------------------
-- Telescope
-- --------------------------------------------------------------------
Group.new("TelescopeNormal", c.darkStep12, c.darkStep1)
Group.new("TelescopeBorder", c.darkStep7, c.darkStep1)
Group.new("TelescopePromptPrefix", c.darkStep9, nil)
Group.new("TelescopeSelection", nil, c.diffAddedBg:light():light():light())
Group.new("TelescopeMatching", c.darkAccent, nil, s.bold)
