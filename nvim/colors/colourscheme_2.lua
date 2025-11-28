vim.cmd "highlight clear"

if vim.fn.exists "syntax_on" then
  vim.cmd "syntax reset"
end

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "colourscheme_2"

local function hi(group, opts)
  local cmd = "highlight " .. group
  if opts.fg then
    cmd = cmd .. " guifg=" .. opts.fg
  end
  if opts.bg then
    cmd = cmd .. " guibg=" .. opts.bg
  end
  if opts.sp then
    cmd = cmd .. " guisp=" .. opts.sp
  end
  if opts.style then
    cmd = cmd .. " gui=" .. opts.style
  end
  vim.cmd(cmd)
end

local c = {
  bg = "#0e0e0e",
  fg = "#d4d4d4",
  line = "#3e3e3e",
  line_light = "#565656",
  selection = "#507799",
  selection_dark = "#3A5670",
  comment = "#808080",
  keyword = "#c586c0",
  violet = "#b294bb",
  number = "#D79275",
  string = "#A9CF95",
  func = "#dcdcaa",
  operator = "#d4d4d4",
  constant = "#9cdcfe",
  type = "#4ec9b0",
  type_light = "#6BD9C4",
  special = "#d16969",
  pmenu = "#0a0a0a",
  pmenu_sel = "#404040",
  pmenu_sbar = "#1a1a1a",
  pmenu_thumb = "#5a5a5a",
  border = "#5a5a5a",
  field = "#A9CF95",
  property = "#4ec9b0",
  blue = "#569CD6",
  lightblue = "#7592B3",
  tabline = "#242424",
  popblue = "#46ACB8",
  cursorline_bg = "#212327",
  statusline_bg = "#66809E",
  black = "#000000",

  tex_command = "#c586c0",
  tex_env = "#4ec9b0",
  tex_arg = "#9cdcfe",
  tex_math = "#b5cea8",
  tex_label = "#dcdcaa",
  tex_comment = "#6a9955",
  tex_special = "#d16969",

  -- Diagnostic colors
  diag_error = "#f48771",
  diag_warn = "#d7ba7d",
  diag_info = "#75beff",
  diag_hint = "#b294bb",
}

hi("Normal", { fg = c.fg, bg = c.bg })
hi("Visual", { bg = c.selection })
hi("CursorLine", { bg = c.cursorline_bg })
hi("CursorLineNr", { fg = c.func, style = "bold" })
hi("LineNr", { fg = c.line })
hi("Winseparator", { fg = c.line })
hi("NonText", { fg = c.line })
hi("EndOfBuffer", { fg = c.line })
hi("MatchParen", { fg = c.func, bg = c.border, style = "bold" })

hi("Pmenu", { fg = c.fg, bg = c.cursorline_bg })
hi("PmenuSel", { fg = c.fg, bg = c.selection, style = "none" })
hi("PmenuSbar", { bg = c.pmenu_sbar })
hi("PmenuThumb", { bg = c.pmenu_thumb })
hi("NormalFloat", { fg = c.fg, bg = c.bg })
hi("FloatBorder", { fg = c.line, bg = c.bg })
hi("TelescopeBorder", { fg = c.line })
hi("TelescopeSelection", { fg = c.bg, bg = c.lightblue })
hi("TelescopeMatching", { fg = c.func, style = "bold" })

hi("BlinkCmpMenu", { bg = c.bg })
hi("BlinkCmpMenuBorder", { fg = c.line, bg = c.bg })
hi("BlinkCmpDoc", { bg = c.bg })
hi("BlinkCmpDocBorder", { fg = c.line, bg = c.bg })
hi("BlinkCmpSignatureHelp", { bg = c.bg })
hi("BlinkCmpSignatureHelpBorder", { fg = c.line, bg = c.bg })
hi("BlinkCmpSignatureHelpActiveParameter", { bg = c.selection })
hi("BlinkCmpDocSeparator", { bg = c.bg })
hi("BlinkCmpKind", { fg = c.fg, bg = c.bg })
hi("BlinkCmpSource", { fg = c.fg, bg = c.bg })

-- hi("BlinkCmpMenu", { bg = c.cursorline_bg })
-- hi("BlinkCmpMenuBorder", { bg = c.cursorline_bg })
-- hi("BlinkCmpSource", { fg = c.fg, bg = c.cursorline_bg })
-- hi("BlinkCmpKind", { fg = c.fg, bg = c.cursorline_bg })
-- hi("BlinkCmpDoc", { bg = c.black })
-- hi("BlinkCmpDocBorder", { fg = c.black, bg = c.tabcursorline_bg })
-- hi("BlinkCmpSignatureHelp", { bg = c.black })
-- hi("BlinkCmpSignatureHelpBorder", { fg = c.black, bg = c.tabcursorline_bg })
-- hi("BlinkCmpSignatureHelpActiveParameter", { bg = c.selection })
-- hi("BlinkCmpDocSeparator", { bg = c.black })

hi("StatusLine", { fg = c.comment, bg = c.cursorline_bg })
hi("StatusLineNC", { fg = c.line, bg = c.statusline_bg })
hi("TabLine", { fg = c.line, bg = c.bg })
hi("TabLineSel", { fg = c.bg, bg = c.lightblue })
hi("TabLineFill", { bg = c.bg })
hi("StatusLineHeader", { fg = c.comment, bg = c.cursorline_bg })
hi("StatusLineHeaderNorm", { fg = c.fg, bg = c.pmenu_sel })
hi("StatusLinePos", { fg = c.bg, bg = c.statusline_bg })

hi("Comment", { fg = c.comment, style = "italic" })
hi("Constant", { fg = c.constant })
hi("String", { fg = c.number })
hi("Number", { fg = c.special })
hi("Boolean", { fg = c.property })
hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.func })
hi("Statement", { fg = c.keyword })
hi("Keyword", { fg = c.keyword })
hi("Operator", { fg = c.operator })
hi("Type", { fg = c.type })
hi("Special", { fg = c.special })
hi("Field", { fg = c.field })

hi("LspReferenceText", { bg = c.selection_dark })

hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.special })
hi("@variable.parameter", { fg = c.constant })
hi("@variable.member", { fg = c.type })

hi("@function", { fg = c.func })
hi("@function.builtin", { fg = c.constant })
hi("@function.call", { fg = c.type })
hi("@function.method", { fg = c.func })
hi("@function.method.call", { fg = c.func })
hi("@function.macro", { fg = c.func })

hi("@module", { fg = c.func })
hi("@module.builtin", { fg = c.type })
hi("@module.builtin.lua", { fg = c.type })

hi("@keyword", { fg = c.lightblue })
hi("@keyword.function", { fg = c.constant })
hi("@keyword.operator", { fg = c.keyword })
hi("@keyword.return", { fg = c.violet })
hi("@keyword.conditional", { fg = c.violet })
hi("@keyword.repeat", { fg = c.constant })
hi("@keyword.exception", { fg = c.keyword })
hi("@keyword.import", { fg = c.constant })

hi("@constant", { fg = c.constant })
hi("@constant.builtin", { fg = c.constant })
hi("@constant.macro", { fg = c.constant })

hi("@string", { fg = c.number })
hi("@string.escape", { fg = c.special, style = "italic" })
hi("@string.regex", { fg = c.number, style = "italic" })
hi("@string.special", { fg = c.number, style = "italic" })

hi("@number", { fg = c.special })
hi("@boolean", { fg = c.property })

hi("@type", { fg = c.type })
hi("@type.builtin", { fg = c.type, style = "bold" })
hi("@type.definition", { fg = c.type })

hi("@property", { fg = c.constant })
hi("@field", { fg = c.field })
hi("@constructor", { fg = c.func })

hi("@punctuation", { fg = c.operator })
hi("@punctuation.bracket", { fg = c.operator })
hi("@punctuation.delimiter", { fg = c.operator })
hi("@punctuation.special", { fg = c.operator })

hi("@comment", { fg = c.comment, style = "italic" })
hi("@comment.documentation", { fg = c.comment, style = "italic" })

hi("@operator", { fg = c.operator })

hi("@label", { fg = c.keyword })

hi("@tag", { fg = c.keyword })
hi("@tag.attribute", { fg = c.fg })
hi("@tag.delimiter", { fg = c.operator })

hi("@lsp.type.class", { fg = c.type })
hi("@lsp.type.function", { fg = c.func })
hi("@lsp.type.variable", { fg = c.fg })
hi("@lsp.type.keyword", { fg = c.keyword })
hi("@lsp.type.property", { fg = c.type_light })
hi("@lsp.type.namespace", { fg = c.type })
hi("@lsp.type.parameter", { fg = c.fg })
hi("@lsp.type.comment", { fg = c.comment, style = "italic" })
hi("@lsp.mod.defaultLibrary.lua", { fg = c.type })

hi("DiagnosticError", { fg = c.diag_error })
hi("DiagnosticWarn", { fg = c.diag_warn })
hi("DiagnosticInfo", { fg = c.diag_info })
hi("DiagnosticHint", { fg = c.diag_hint })
hi("DiagnosticUnderlineError", { sp = c.diag_error, style = "undercurl" })
hi("DiagnosticUnderlineWarn", { sp = c.diag_warn, style = "undercurl" })
hi("DiagnosticUnderlineInfo", { sp = c.diag_info, style = "undercurl" })
hi("DiagnosticUnderlineHint", { sp = c.diag_hint, style = "undercurl" })

hi("TreesitterContext", { bg = c.cursorline_bg })
hi("TreesitterContextLineNumber", { fg = c.line_light, bg = c.cursorline_bg })

hi("@function.macro.tex", { fg = c.tex_command })
hi("@punctuation.delimiter.tex", { fg = c.tex_special })
hi("@comment.tex", { fg = c.tex_comment, style = "italic" })
hi("@string.tex", { fg = c.tex_arg })
hi("@variable.parameter.tex", { fg = c.tex_arg })
hi("@constant.builtin.tex", { fg = c.tex_env })
hi("@label.tex", { fg = c.tex_label })
hi("@math.tex", { fg = c.tex_math })

hi("texCmd", { fg = c.tex_command })
hi("texBeginEnd", { fg = c.tex_env })
hi("texArg", { fg = c.tex_arg })
hi("texMath", { fg = c.tex_math })
hi("texRefZone", { fg = c.tex_label })
hi("texComment", { fg = c.tex_comment, style = "italic" })
hi("texDelim", { fg = c.tex_special })
hi("texSection", { fg = c.tex_command, style = "bold" })
hi("texStatement", { fg = c.tex_command })

hi("@lsp.type.namespace.tex", { fg = c.type })
hi("@lsp.type.macro.tex", { fg = c.tex_command })
hi("@lsp.type.function.tex", { fg = c.tex_command })
hi("@lsp.type.comment.tex", { fg = c.tex_comment, style = "italic" })
hi("@lsp.type.string.tex", { fg = c.tex_arg })
hi("@lsp.type.variable.tex", { fg = c.tex_arg })
hi("@lsp.type.keyword.tex", { fg = c.tex_env })

vim.opt.winborder = "rounded"
