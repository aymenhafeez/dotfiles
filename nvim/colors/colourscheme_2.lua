-- ~/.config/nvim/colors/dracula-soft.lua
-- Exact Grok code block colors + FULL Tree-sitter support
-- Converted to colorbuddy

vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then
  vim.cmd "syntax reset"
end
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "colourscheme_2"

local colorbuddy = require "colorbuddy"
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

-- === EXACT GROK CODE BLOCK COLORS ===
-- Color.new("bg", "#050505") -- TRUE background
Color.new("bg", "#0a0a0a") -- TRUE background
Color.new("fg", "#d4d4d4") -- Default text
Color.new("line", "#3e3e3e") -- Line numbers
Color.new("selection", "#38556e") -- Visual
Color.new("comment", "#808080")
Color.new("keyword", "#c586c0") -- if, def, return
Color.new("violet", "#b294bb")
Color.new("string", "#ce9178") -- "strings"
Color.new("number", "#b5cea8") -- 123
Color.new("func", "#dcdcaa") -- function names
-- Color.new("func", "#e5c07b")
Color.new("operator", "#d4d4d4") -- () + -
Color.new("constant", "#9cdcfe") -- True, None
Color.new("type", "#4ec9b0") -- int, str
Color.new("special", "#d16969") -- self
Color.new("pmenu", "#0a0a0a")
Color.new("pmenu_sel", "#404040")
Color.new("pmenu_sbar", "#1a1a1a")
Color.new("pmenu_thumb", "#5a5a5a")
Color.new("field", "#b5cea8")
Color.new("property", "#4ec9b0")
Color.new("blue", "#569CD6")
Color.new("tabline", "#242424")
Color.new("popblue", "#46ACB8")
Color.new("cursorline_bg", "#0f0f0f")
Color.new("colorcolumn_bg", "#0a0a0a")
Color.new("statusline_bg", "#81a2be")

-- LaTeX colors
Color.new("tex_command", "#c586c0")
Color.new("tex_env", "#4ec9b0")
Color.new("tex_arg", "#9cdcfe")
Color.new("tex_math", "#b5cea8")
Color.new("tex_label", "#dcdcaa")
Color.new("tex_comment", "#6a9955")
Color.new("tex_special", "#d16969")

-- Diagnostic colors
Color.new("diag_error", "#f48771")
Color.new("diag_warn", "#d7ba7d")
Color.new("diag_info", "#75beff")
Color.new("diag_hint", "#c5c5c5")

-- === EDITOR UI ===
Group.new("Normal", c.fg, c.bg)
Group.new("Visual", c.none, c.selection)
Group.new("Cursor", c.bg, c.fg)
Group.new("CursorLine", c.none, c.cursorline_bg)
Group.new("CursorLineNr", c.func, c.none, s.bold)
Group.new("LineNr", c.line, c.none)
Group.new("SignColumn", c.none, c.bg)
Group.new("ColorColumn", c.none, c.colorcolumn_bg)
Group.new("VertSplit", c.line, c.none)
Group.new("NonText", c.line, c.none)
Group.new("EndOfBuffer", c.line, c.none)

-- === POPUP MENU ===
Group.new("Pmenu", c.fg, c.pmenu)
Group.new("PmenuSel", c.fg, c.selection)
Group.new("PmenuSbar", c.none, c.pmenu_sbar)
Group.new("PmenuThumb", c.none, c.pmenu_thumb)
Group.new("TelescopeSelection", c.none, c.selection)
Group.new("TelescopeMatching", c.string, c.none, s.bold)

-- === STATUSLINE / TABLINE ===
Group.new("StatusLine", c.line, c.statusline_bg)
Group.new("StatusLineNC", c.line, c.statusline_bg)
Group.new("TabLine", c.comment, c.bg)
Group.new("TabLineSel", c.line, c.statusline_bg)
Group.new("TabLineFill", c.none, c.bg)

-- === TRADITIONAL SYNTAX (fallback) ===
Group.new("Comment", c.comment, c.none, s.italic)
Group.new("Constant", c.constant, c.none)
Group.new("String", c.string, c.none)
Group.new("Number", c.number, c.none)
Group.new("Boolean", c.property, c.none)
Group.new("Identifier", c.fg, c.none)
Group.new("Function", c.func, c.none)
Group.new("Statement", c.keyword, c.none)
Group.new("Keyword", c.keyword, c.none)
Group.new("Operator", c.operator, c.none)
Group.new("Type", c.type, c.none)
Group.new("Special", c.special, c.none)
Group.new("Field", c.field, c.none)

-- === FULL TREE-SITTER SUPPORT ===
-- Variables
Group.new("@variable", c.fg, c.none)
Group.new("@variable.builtin", c.special, c.none) -- self, this
Group.new("@variable.parameter", c.constant, c.none)
Group.new("@variable.member", c.field, c.none)

-- Functions
Group.new("@function", c.func, c.none)
Group.new("@function.builtin", c.constant, c.none)
Group.new("@function.call", c.type, c.none)
Group.new("@function.method", c.func, c.none)
Group.new("@function.method.call", c.func, c.none)
Group.new("@function.macro", c.func, c.none)

-- Modules
Group.new("@module", c.func, nil)
Group.new("@module.builtin", c.type, c.none)
Group.new("@module.builtin.lua", c.type, c.none)

-- Keywords
Group.new("@keyword", c.violet, c.none)
Group.new("@keyword.function", c.constant, c.none)
Group.new("@keyword.operator", c.keyword, c.none)
Group.new("@keyword.return", c.keyword, c.none)
Group.new("@keyword.conditional", c.field, c.none)
Group.new("@keyword.repeat", c.constant, c.none)
Group.new("@keyword.exception", c.keyword, c.none)

-- Constants
Group.new("@constant", c.constant, c.none)
Group.new("@constant.builtin", c.constant, c.none)
Group.new("@constant.macro", c.constant, c.none)

-- Strings
Group.new("@string", c.string, c.none)
Group.new("@string.escape", c.special, c.none, s.italic)
Group.new("@string.regex", c.string, c.none, s.italic)
Group.new("@string.special", c.string, c.none, s.italic)

-- Numbers & Booleans
Group.new("@number", c.number, c.none)
Group.new("@boolean", c.property, c.none)

-- Types
Group.new("@type", c.type, c.none)
Group.new("@type.builtin", c.type, c.none, s.bold)
Group.new("@type.definition", c.type, c.none)

-- Properties & Fields
Group.new("@property", c.constant, c.none)
Group.new("@field", c.field, c.none)
Group.new("@constructor", c.func, c.none) -- Class()

-- Punctuation
Group.new("@punctuation", c.operator, c.none)
Group.new("@punctuation.bracket", c.operator, c.none)
Group.new("@punctuation.delimiter", c.operator, c.none)
Group.new("@punctuation.special", c.operator, c.none)

-- Comments
Group.new("@comment", c.comment, c.none, s.italic)
Group.new("@comment.documentation", c.comment, c.none, s.italic)

-- Operators
Group.new("@operator", c.operator, c.none)

-- Labels
Group.new("@label", c.keyword, c.none)

-- Tags (HTML, etc.)
Group.new("@tag", c.keyword, c.none)
Group.new("@tag.attribute", c.fg, c.none)
Group.new("@tag.delimiter", c.operator, c.none)

-- LSP / Diagnostics
Group.new("@lsp.type.class", c.type, c.none)
Group.new("@lsp.type.function", c.func, c.none)
Group.new("@lsp.type.variable", c.fg, c.none)
Group.new("@lsp.type.keyword", c.keyword, c.none)
Group.new("@lsp.type.property", c.statusline_bg:light(), c.none)
Group.new("@lsp.type.namespace", c.type, c.none)
Group.new("@lsp.type.parameter", c.fg, c.none)
Group.new("@lsp.type.comment", g.Comment, g.Comment, g.Comment)
Group.new("@lsp.mod.defaultLibrary.lua", c.type, c.none)

-- === DIAGNOSTICS ===
Group.new("DiagnosticError", c.diag_error, c.none)
Group.new("DiagnosticWarn", c.diag_warn, c.none)
Group.new("DiagnosticInfo", c.diag_info, c.none)
Group.new("DiagnosticHint", c.diag_hint, c.none)
Group.new("DiagnosticUnderlineError", c.none, c.none, s.undercurl, c.diag_error)
Group.new("DiagnosticUnderlineWarn", c.none, c.none, s.undercurl, c.diag_warn)

--------------------------------------------------------------------
--  LaTeX HIGHLIGHTING (Tree-sitter + classic groups)
--------------------------------------------------------------------

----------------------------------------------------------------
-- 1. Tree-sitter groups (nvim-treesitter)
----------------------------------------------------------------
Group.new("@function.macro.tex", c.tex_command, c.none) -- \command
Group.new("@punctuation.delimiter.tex", c.tex_special, c.none) -- \{, \}, \&
Group.new("@comment.tex", c.tex_comment, c.none, s.italic)
Group.new("@string.tex", c.tex_arg, c.none) -- text inside {…}
Group.new("@variable.parameter.tex", c.tex_arg, c.none) -- optional args
Group.new("@constant.builtin.tex", c.tex_env, c.none) -- \begin, \end
Group.new("@label.tex", c.tex_label, c.none) -- \label, \ref
Group.new("@math.tex", c.tex_math, c.none) -- $…$

----------------------------------------------------------------
-- 2. Classic Vim-LaTeX groups (fallback for non-TS buffers)
----------------------------------------------------------------
Group.new("texCmd", c.tex_command, c.none)
Group.new("texBeginEnd", c.tex_env, c.none)
Group.new("texArg", c.tex_arg, c.none)
Group.new("texMath", c.tex_math, c.none)
Group.new("texRefZone", c.tex_label, c.none)
Group.new("texComment", c.tex_comment, c.none, s.italic)
Group.new("texDelim", c.tex_special, c.none)
Group.new("texSection", c.tex_command, c.none, s.bold)
Group.new("texStatement", c.tex_command, c.none)

----------------------------------------------------------------
-- 3. LSP semantic tokens (if you use texlab, ltex-ls, etc.)
----------------------------------------------------------------
Group.new("@lsp.type.namespace.tex", g["@module.builtin"], g["@module.builtin"], g["@module.builtin"])
Group.new("@lsp.type.macro.tex", c.tex_command, c.none)
Group.new("@lsp.type.function.tex", c.tex_command, c.none)
Group.new("@lsp.type.comment.tex", c.tex_comment, c.none, s.italic)
Group.new("@lsp.type.string.tex", c.tex_arg, c.none)
Group.new("@lsp.type.variable.tex", c.tex_arg, c.none)
Group.new("@lsp.type.keyword.tex", c.tex_env, c.none)
