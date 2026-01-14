local nvim_set_hl = vim.api.nvim_set_hl

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

local mod = require("ah.utils").modify_colour
local lighter = require("ah.utils").lighter
local darker = require("ah.utils").darker

local fg = lighter "#D3D9DF"
local bg = "#181a1b"
local white = "#f2e5bc"
local gray1 = "#3f4349"
local red = "#cc6666"
local green = "#94c794"
local yellow = "#FAC03B"
local blue = "#81a1c1"
-- local blue = "#7398dd"
local darkblue = "#4377b8"
local visual = "#3E5366"
local teal = "#88c0d0"
local cyan = "#8bb3ad"
local purple = "#9177b5"
local violet = "#9185BE"
local orange = "#db956a"
local ochre = "#e2847a"
local statusline_bg = mod(bg, 130)
local border = "#393E47"
local comment = lighter "#797B80"
local gutter = "#1E2024"

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
vim.g.terminal_color_15 = lighter(fg)

local highlights = {
	Normal = { fg = fg, bg = bg },
	LineNr = { fg = comment, bg = gutter },
	CursorLine = { bg = mod(gutter, 30) },
	CursorLineNr = { fg = lighter(fg), bg = gutter, bold = true },
	Conceal = { fg = ochre },
	Comment = { fg = comment, italic = true },
	WinSeparator = { fg = comment },
	MatchParen = { bg = gray1, bold = true },
	EndOfBuffer = { fg = bg },
	ModeMsg = { fg = yellow },
	Question = { link = "ModeMsg" },
	MoreMsg = { link = "ModeMsg" },
	Bold = { fg = lighter(fg), bold = true },
	Visual = { bg = visual },
	VisualNonText = { bg = visual, fg = comment },
	Title = { fg = green, bold = true },
	Number = { fg = lighter(fg), bold = true },
	Todo = { fg = bg, bg = teal, bold = true },

	Pmenu = { bg = darker(border) },
	PmenuSel = { bg = comment },

	Tabline = { fg = comment, bg = mod(border, -20) },
	TablineFill = { bg = mod(border, -20) },
	TablineSel = { fg = fg, bg = bg, bold = true },

	Winbar = { fg = darker(fg), bg = bg },
	WinbarNC = { fg = darker(comment), bg = bg },

	StatusLine = { fg = mod(fg, -30), bg = border },
	StatusLineNc = { fg = mod(fg, -40), bg = mod(border, -20) },
	StatusLineHeader = { fg = yellow, bg = border, bold = true },
	StatusLineHeaderNC = { fg = comment, bg = bg },
	StatusLineHeaderNorm = { link = "StatusLine" },
	StatusLineHeaderCmd = { fg = yellow, bg = border, bold = true },
	StatusLineHeaderTerm = { fg = yellow, bg = border },
	StatusLineLsp = { fg = darker(fg), bg = mod(border, 35) },
	StatusLinePos = { link = "StatusLine" },
	StatusLineBufName = { fg = lighter(fg), bold = true },

	DiagnosticUnderlineError = { sp = red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = lighter(yellow), undercurl = true },
	DiagnosticUnderlineInfo = { sp = blue, undercurl = true },
	DiagnosticUnderlineHint = { sp = teal, undercurl = true },
	DiagnosticUnderlineOk = { sp = green, undercurl = true },

	LspReferenceText = { bg = visual },
	LspReferenceRead = { bg = visual },
	LspReferenceWrite = { bg = visual },

	SpellBad = { sp = red, undercurl = true },
	SpellLocal = { sp = red, undercurl = true },
	SpellRare = { sp = red, undercurl = true },
	SpellCap = { sp = red, undercurl = true },

	TelescopeBorder = { fg = comment },
	TelescopeMatching = { fg = ochre, bold = true },
	TelescopeSelection = { link = "PmenuSel" },

	BlinkCmpLabelMatch = { fg = ochre, bold = true },
	BlinkCmpKind = { fg = blue },
	BlinkCmpGhostText = { fg = comment },

	BlinkCmpKindStruct = { fg = yellow },
	BlinkCmpKindFunction = { fg = blue },
	BlinkCmpKindText = { fg = cyan },
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

	["@constant"] = { fg = orange, bold = true },
	["@constant.builtin"] = { fg = ochre, bold = false },
	["@boolean"] = { fg = yellow, bold = true },
	["@string"] = { fg = green },

	["@function"] = { fg = lighter(blue), bold = true },
	["@function.method"] = { fg = teal },
	["@function.call"] = { fg = lighter(blue), bold = false },
	["@function.method.call"] = { fg = teal },
	["@function.builtin"] = { fg = lighter(teal), bold = true },
	["@function.bracket"] = { fg = fg, bg = bg },

	["@keyword"] = { fg = violet },
	["@keyword.conditional"] = { fg = yellow, bold = true },
	["@keyword.function"] = { fg = violet, italic = true },
	["@keyword.faded"] = { fg = comment },
	["@keyword.repeat"] = { fg = yellow, bold = true },
	["@keyword.return"] = { fg = violet, italic = true },
	["@keyword.exception"] = { link = "@keyword.conditional" },
	["@keyword.operator"] = { fg = yellow, bold = true },
	["@keyword.import"] = { fg = yellow, bold = true },

	["@type.builtin"] = { fg = violet },

	["@module"] = { fg = fg },
	["@module.builtin"] = { fg = yellow, bold = true },

	["@property"] = { fg = lighter(blue) },

	["@variable"] = { fg = fg },
	["@variable.builtin"] = { fg = violet, bg = bg },
	["@variable.member"] = {},
	["@variable.parameter"] = { fg = yellow, bold = true },

	["@constructor"] = { bold = false },

	["@punctuation"] = { fg = white },
	["@punctuation.bracket"] = { fg = white },
	["@punctuation.special"] = { fg = violet },

	["@variable.builtin.python"] = { fg = yellow },
	["@type.python"] = { fg = violet },

	["@function.latex"] = { fg = blue },
	["@keyword.import.latex"] = { fg = violet },
	["@string.special.path.latex"] = { fg = green },
	["@module.latex"] = { fg = blue },
	["@variable.parameter.latex"] = { fg = teal },

	texEnvArgName = { fg = yellow, bold = true },
	texCmd = { fg = violet },
	texBeginEnd = { fg = teal },
	texArg = { fg = blue },
	texMath = { fg = green },
	texRefZone = { fg = lighter(yellow) },
	texComment = { fg = green, italic = true },
	texDelim = { fg = red },
	texSection = { fg = violet, bold = true },
	texStatement = { fg = violet },
	texEnvOpt = { fg = green },
	texFileOpt = { link = "Number" },
}

for group, opts in pairs(highlights) do
	nvim_set_hl(0, group, opts)
end

vim.g.colors_name = "colourscheme_dark"
