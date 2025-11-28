vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then
  vim.cmd "syntax reset"
end

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "colourscheme"

-- helper function to set highlights
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

-- define colors
local c = {
  white = "#f2e5bc",
  superwhite = "#e0e0e0",
  lightgray = "#3D4149",
  lightergray = "#4A4E56",
  lightgray_light = "#4F535B",
  lightgray_lighter = "#9a9a9a",
  gray1 = "#23272F",
  darkgray = "#1E2228",
  red = "#cc6666",
  pink = "#fef601",
  green = "#99cc99",
  yellow_bright = "#f8fe7a",
  yellow = "#FAFF96",
  yellow_light = "#FCFFB8",
  blue = "#81A2BE",
  blue_dark = "#5A7A94",
  blue_dark_dark = "#3E5366",
  blue_dark_dark_dark = "#2D3D4D",
  teal = "#90CFC0",
  popblue = "#46ACB8",
  aqua = "#8ec07c",
  cyan = "#8abeb7",
  purple = "#8e6fbd",
  purple_light = "#A591D1",
  purple_light_light = "#BCB3E5",
  violet = "#b294bb",
  violet_light = "#C9B3CF",
  orange = "#de935f",
  ochre = "#e87c69",
  brown = "#a3685a",
  seagreen = "#698b69",
  turquoise = "#698b69",
  -- statusline_bg = "#778CA5",
  statusline_bg = "#7FA1BC",
  fg = "#d0d0d0",
  -- bg = "#262a32",
  bg = "#282c34",
  bg_light = "#30353D",
  comment_light = "#4F535B",
  NvimLightGrey3 = "#C4C6CD",
  blue_grey = "#51545E",
  blue_grey_dark = "#1E2027",
  blue_grey_light = "#3F444D",
}

hi("Normal", { fg = c.fg, bg = c.bg })
hi("LineNr", { fg = c.lightgray, bg = c.bg })
hi("Conceal", { fg = c.ochre, bg = c.bg })
hi("Comment", { fg = c.comment_light, style = "italic" })
hi("WinSeparator", { fg = c.fg, bg = c.bg, style = "none" })
hi("DiagnosticUnderlineError", { fg = c.red, style = "undercurl" })
hi("DiagnosticUnderlineWarn", { sp = c.yellow_light, style = "undercurl" })
hi("DiagnosticUnderlineInfo", { sp = c.blue, style = "undercurl" })
hi("DiagnosticUnderlineeHint", { sp = c.aqua, style = "undercurl" })
hi("DiagnosticUnderlineeOk", { sp = c.green, style = "undercurl" })
hi("DiagnosticUnnecessary", { style = "none" })
hi("MatchParen", { fg = c.yellow, bg = c.lightgray_light, style = "bold" })
hi("EndOfBuffer", { fg = c.bg, style = "none" })
hi("ModeMsg", { fg = c.yellow, style = "none" })
hi("Visual", { bg = c.blue_dark, style = "none" })
hi("Pmenu", { bg = c.lightergray })
hi("NormalFloat", { bg = c.blue_grey_dark })
hi("Tabline", { fg = c.lightgray_lighter, bg = c.bg_light })
hi("TablineSel", { fg = c.bg, bg = c.blue })
hi("StatusLineNc", { fg = c.lightgray_lighter, bg = c.blue_grey_light })
hi("StatusLine", { fg = c.bg_light, bg = c.NvimLightGrey3 })
hi("StatusLineHeader", { fg = c.bg, style = "bold" })
hi("StatusLineHeaderNorm", { fg = c.yellow, bg = c.bg, style = "bold" })
hi("StatusLineHeaderCmd", { fg = c.orange, bg = c.bg, style = "bold" })
hi("StatusLineHeaderTerm", { fg = c.green, bg = c.bg, style = "bold" })
hi("StatusLinePos", { fg = c.bg, bg = c.statusline_bg })
hi("StatusLineTerm", { fg = c.bg, bg = c.statusline_bg })
hi("LspReferenceText", { bg = c.blue_dark_dark_dark, style = "none" })
hi("LspReferenceRead", { bg = c.blue_dark_dark_dark, style = "none" })
hi("LspReferenceWrite", { bg = c.blue_dark_dark_dark, style = "none" })
hi("Number", { fg = c.ochre, style = "none" })
hi("Cursorline", { bg = c.bg_light })
hi("SpellBad", { sp = c.red, style = "undercurl" })
hi("SpellLocal", { sp = c.red, style = "undercurl" })
hi("SpellRare", { sp = c.red, style = "undercurl" })
hi("SpellCap", { sp = c.red, style = "undercurl" })
hi("TelescopeMatching", { fg = c.orange, style = "bold" })
hi("BlinkCmpLabelMatch", { fg = c.ochre, style = "bold" })
hi("BlinkCmpKind", { fg = c.blue })
hi("BlinkCmpMenuSelection", { fg = c.bg, bg = c.NvimLightGrey3, style = "none" })

hi("@constant", { fg = c.orange, style = "none" })
hi("@boolean", { fg = c.orange, style = "none" })
hi("@function", { fg = c.yellow, style = "none" })
hi("@function.builtin", { fg = c.yellow, style = "none" })
hi("@function.method", { fg = c.yellow, style = "none" })
hi("@function.call", { fg = c.teal, style = "none" })
hi("@function.method.call", { fg = c.yellow, style = "none" })
hi("@function.bracket", { fg = c.fg, bg = c.bg })
hi("@keyword", { fg = c.violet, style = "none" })
hi("@keyword.conditional", { fg = c.ochre, style = "none" })
hi("@keyword.function", { fg = c.blue, style = "none" })
hi("@keyword.faded", { fg = c.comment_light, style = "none" })
hi("@keyword.repeat", { fg = c.ochre, style = "none" })
hi("@keyword.return", { fg = c.violet, style = "italic" })
hi("@keyword.exception", { fg = c.blue, style = "none" })
hi("@type.builtin", { fg = c.violet, style = "bold" })
hi("@module", { fg = c.blue })
hi("@module.builtin", { fg = c.blue })
hi("@property", { fg = c.blue })
hi("@variable", { fg = c.superwhite })
hi("@variable.builtin", { fg = c.purple_light_light, bg = c.bg })
hi("@variable.member", { fg = c.blue })
hi("@variable.parameter", { fg = c.blue })
hi("@constructor", { fg = c.violet })
hi("@punctuation", { fg = c.superwhite })
hi("@punctuation.special", { fg = c.violet })
hi("@string", { fg = c.green })

hi("@comment", { fg = c.comment_light, style = "italic" })
hi("@comment.todo", { fg = c.bg, bg = c.blue, style = "italic" })
hi("Todo", { fg = c.bg, bg = c.blue, style = "italic" })
-- TODO:
hi("@lsp.type.method", { fg = c.yellow, style = "none" })
hi("@lsp.type.namespace", { fg = c.yellow, style = "none" })
hi("@lsp.typemod.function.defaultLibrary.lua", { fg = c.blue, style = "none" })

hi("TreesitterContext", { bg = c.bg_light })
hi("TreesitterContextLineNumber", { fg = c.blue, bg = c.bg_light })

hi("@function.lua", { fg = c.yellow })
hi("@function.call.lua", { fg = c.teal })
hi("@lsp.type.method", { fg = c.teal })
hi("@variable.builtin.python", { fg = c.red })
hi("@type.python", { fg = c.yellow })
hi("texEnvArgName", { fg = c.blue })
