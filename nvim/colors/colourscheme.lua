local nvim_set_hl = vim.api.nvim_set_hl

local mod = require("ah.utils").modify_colour
local lighter = require("ah.utils").lighter
local darker = require("ah.utils").darker

local white = "#f2e5bc"
local superwhite = "#f0f0f0"
local gray1 = "#3f4349"
local red = "#cc6666"
local green = "#94c794"
local yellow = "#f7fc9b"
local light_yellow = "#f9fcb3"
local dark_yellow = "#ebcb8b"
local blue = "#81a2be"
local blue_dark = "#486F82"
local blue_dark_dark = "#3E5366"
local teal = "#88c0d0"
local aqua = "#8bb88a"
local cyan = "#8bb3ad"
local purple = "#9177b5"
local violet = "#BBA3C1"
local orange = "#db956a"
local ochre = "#e2847a"
local statusline_bg = "#81a2be"
local fg = "#D3D9DF"
local fg_dark = "#9a9a9a"
local bg = "#282c34"
local bg_dark = "#27292B"
local bg_darker = "#141518"
local border = "#393E47"
local comment = "#797B80"
local comment_dark = "#4F535B"
local NvimLightGrey3 = "#C4C6CD"
local term_bg = "#23262B"
local tex_command = "#c586c0"
local tex_env = "#93E4E2"
local tex_arg = "#9cdcfe"
local tex_math = "#b5cea8"
local tex_label = "#dcdcaa"
local tex_comment = "#6a9955"
local tex_special = "#d16969"

local bg_lighter = lighter(lighter(bg))
local cyan_lighter = lighter(cyan)
local bg_statusline_lighter = lighter(bg)
local bg_tabline = lighter(lighter(bg))
local red_mod = mod(red, 70)

-- statusline_bg = darkblue

vim.g.terminal_color_0 = bg
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = blue
vim.g.terminal_color_5 = purple
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = fg
vim.g.terminal_color_8 = gray1
vim.g.terminal_color_9 = red
vim.g.terminal_color_10 = green
vim.g.terminal_color_11 = yellow
vim.g.terminal_color_12 = blue
vim.g.terminal_color_13 = purple
vim.g.terminal_color_14 = cyan
vim.g.terminal_color_15 = superwhite

local highlights = {
	Normal = { fg = fg, bg = bg },
	TerminalNormal = { fg = NvimLightGrey3, bg = term_bg },
	LineNr = { fg = fg_dark, bg = bg_dark },
	CursorLine = { bg = bg_lighter },
	CursorLineNr = { fg = superwhite, bg = bg_dark, bold = true },
	Conceal = { fg = ochre, bg = bg },
	Comment = { fg = comment, italic = true },
	WinSeparator = { fg = NvimLightGrey3 },
	MatchParen = { fg = yellow, bg = gray1, bold = true },
	EndOfBuffer = { fg = bg },
	ModeMsg = { fg = teal },
	Bold = { fg = superwhite, bold = true },
	Visual = { bg = blue_dark },
	VisualNonText = { bg = blue_dark, fg = fg_dark },
	Title = { fg = green, bold = true },

	Pmenu = { bg = gray1 },
	PmenuSel = { bg = blue_dark },
	PmenuThumb = { bg = comment_dark },
	NormalFloat = { bg = bg_darker },
	FloatBorder = { bg = bg_darker, fg = bg_darker },
	FloatTitle = { bg = bg_darker, fg = green },

	Tabline = { fg = blue, bg = bg_tabline },
	TablineFill = { bg = fg_dark },
	TablineSel = { fg = fg, bg = bg, bold = true },

	Winbar = { fg = NvimLightGrey3, bg = bg },
	WinbarNC = { fg = comment_dark, bg = bg },

	StatusLine = { fg = bg_statusline_lighter, bg = statusline_bg },
	StatusLineNc = { fg = lighter(fg_dark), bg = gray1 },
	StatusLineHeader = { fg = bg_statusline_lighter, bg = statusline_bg },
	StatusLineHeaderNC = { fg = comment, bg = bg },
	StatusLineTerm = { fg = bg_statusline_lighter, bg = statusline_bg },
	StatusLineHeaderNorm = { fg = yellow, bg = bg, bold = true },
	StatusLineHeaderCmd = { fg = orange, bg = bg, bold = true },
	StatusLineHeaderTerm = { fg = bg_statusline_lighter, bg = statusline_bg },
	StatusLineLsp = { fg = bg, bg = statusline_bg },
	StatusLinePos = { link = "StatusLine" },
	StatusLineBufName = { fg = superwhite, bold = true },
	StatusLineDiag = { bg = statusline_bg, bold = true },

	DiagnosticError = { fg = red, undercurl = true },
	DiagnosticWarn = { sp = yellow, undercurl = true },
	DiagnosticInfo = { sp = blue, undercurl = true },
	DiagnosticeHint = { sp = aqua, undercurl = true },
	DiagnosticeOk = { sp = green, undercurl = true },

	DiagnosticSignError = { fg = red },
	DiagnosticSignWarn = { fg = yellow },
	DiagnosticSignInfo = { fg = blue },
	DiagnosticSignHint = { fg = teal },
	DiagnosticSigneOk = { fg = green },

	DiagnosticVirtualTextError = { fg = red },
	DiagnosticVirtualTextWarn = { fg = yellow },
	DiagnosticVirtualTextInfo = { fg = blue },
	DiagnosticVirtualTexteHint = { fg = aqua },
	DiagnosticVirtualTexteOk = { fg = green },

	DiagnosticUnderlineError = { fg = red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = light_yellow, undercurl = true },
	DiagnosticUnderlineInfo = { sp = blue, undercurl = true },
	DiagnosticUnderlineHint = { sp = teal, undercurl = true },
	DiagnosticUnderlineOk = { sp = green, undercurl = true },

	LspReferenceText = { bg = blue_dark_dark },
	LspReferenceRead = { bg = blue_dark_dark },
	LspReferenceWrite = { bg = blue_dark_dark },

	Number = { fg = red },

	SpellBad = { sp = red, undercurl = true },
	SpellLocal = { sp = red, undercurl = true },
	SpellRare = { sp = red, undercurl = true },
	SpellCap = { sp = red, undercurl = true },

	TelescopeMatching = { fg = ochre, bold = true },
	TelescopeSelection = { link = "PmenuSel" },

	BlinkCmpLabelMatch = { fg = ochre, bold = true },
	BlinkCmpKind = { fg = blue },
	BlinkCmpGhostText = { fg = comment },

	BlinkCmpKindStruct = { fg = yellow },
	BlinkCmpKindFunction = { fg = blue },
	BlinkCmpKindText = { fg = cyan_lighter },
	BlinkCmpKindClass = { fg = yellow },
	BlinkCmpKindValue = { fg = orange },
	BlinkCmpKindEnum = { fg = yellow },
	BlinkCmpKindInterface = { fg = yellow },
	BlinkCmpKindMethod = { fg = cyan },
	BlinkCmpKindUnit = { fg = red },
	BlinkCmpKindConstant = { fg = fg },
	BlinkCmpKindField = { fg = violet },
	BlinkCmpKindModule = { fg = orange },
	BlinkCmpKindKeyword = { fg = violet, italic = true },
	BlinkCmpKindEnumMember = { fg = fg },
	BlinkCmpKindProperty = { fg = blue },
	BlinkCmpKindOperator = { fg = orange },
	BlinkCmpKindReference = { fg = fg },
	BlinkCmpKindSnippet = { fg = fg },
	BlinkCmpKindTypeParameter = { fg = yellow },
	BlinkCmpKindVariable = { fg = fg },

	TreesitterContext = { bg = border },
	TreesitterContextLineNumber = { fg = blue, bg = border },

	["@comment"] = { link = "Comment" },
	["@comment.todo"] = { fg = bg, bg = teal, bold = true },
	["@comment.documentation"] = { fg = teal },
	Todo = { fg = bg, bg = teal, bold = true },

	["@constant"] = { fg = orange },
	["@boolean"] = { fg = orange },
	["@string"] = { fg = green },

	["@function"] = { fg = blue, bold = false },
	["@function.method"] = { fg = teal },
	["@function.call"] = { fg = blue, bold = false },
	["@function.method.call"] = { fg = lighter(blue) },
	["@function.builtin"] = { fg = blue, bold = false },
	["@function.bracket"] = { fg = fg, bg = bg },
	["@function.latex"] = { fg = blue },

	["@keyword"] = { fg = violet },
	["@keyword.conditional"] = { fg = red },
	["@keyword.function"] = { fg = violet },
	["@keyword.faded"] = { fg = comment },
	["@keyword.repeat"] = { fg = red },
	["@keyword.return"] = { fg = violet },
	["@keyword.exception"] = { fg = blue },
	["@keyword.operator"] = { fg = red_mod },
	["@keyword.import"] = { fg = cyan },
	["@keyword.import.latex"] = { fg = violet },
	["@string.special.path.latex"] = { fg = green },

	-- ["@attribute"] = { fg = violet },

	["@type.builtin"] = { fg = violet },

	["@module"] = { fg = fg },
	["@module.builtin"] = { fg = blue },
	["@module.latex"] = { fg = blue },

	["@property"] = { fg = teal },

	["@variable"] = { fg = fg },
	["@variable.builtin"] = { fg = yellow, bg = bg },
	-- ["@variable.member"] = { fg = blue },
	["@variable.parameter"] = { fg = lighter(teal) },
	["@variable.parameter.latex"] = { fg = tex_env },

	["@constructor"] = {},

	["@punctuation"] = { fg = white },
	["@punctuation.bracket"] = { fg = white },
	["@punctuation.special"] = { fg = violet },

	["@variable.builtin.python"] = { fg = dark_yellow },
	["@type.python"] = { fg = teal },

	texEnvArgName = { fg = blue },
	texCmd = { fg = tex_command },
	texBeginEnd = { fg = tex_env },
	texArg = { fg = tex_arg },
	texMath = { fg = tex_math },
	texRefZone = { fg = tex_label },
	texComment = { fg = tex_comment, italic = true },
	texDelim = { fg = tex_special },
	texSection = { fg = tex_command, bold = true },
	texStatement = { fg = tex_command },
	texFileOpt = { fg = tex_special },
	texEnvOpt = { fg = tex_math },
}

for group, opts in pairs(highlights) do
	nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "colourscheme"

-- vim.cmd [[source ~/tmp/config_backups/modes_2.lua]]
