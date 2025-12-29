vim.cmd "highlight clear"
if vim.fn.exists "syntax_on" then
	vim.cmd "syntax reset"
end

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "colourscheme"

-- disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

local function hi(group, opts)
	if opts.link then
		vim.api.nvim_set_hl(0, group, { link = opts.link })
		return
	end

	local hl_opts = {}

	if opts.fg then
		hl_opts.fg = opts.fg
	end
	if opts.bg then
		hl_opts.bg = opts.bg
	end
	if opts.sp then
		hl_opts.sp = opts.sp
	end

	if opts.style then
		if opts.style:match "bold" then
			hl_opts.bold = true
		end
		if opts.style:match "italic" then
			hl_opts.italic = true
		end
		if opts.style:match "underline" then
			hl_opts.underline = true
		end
		if opts.style:match "undercurl" then
			hl_opts.undercurl = true
		end
		if opts.style:match "strikethrough" then
			hl_opts.strikethrough = true
		end
		if opts.style:match "underdotted" then
			hl_opts.underdotted = true
		end
		if opts.style == "none" then
			hl_opts.bold = false
			hl_opts.italic = false
			hl_opts.underline = false
			hl_opts.undercurl = false
		end
	end

	if opts.nocombine ~= nil then
		hl_opts.nocombine = opts.nocombine
	end

	vim.api.nvim_set_hl(0, group, hl_opts)
end

local c = {
	white = "#f2e5bc",
	superwhite = "#f0f0f0",
	lightergray = "#4a4a4a",
	gray1 = "#3f4349",
	red = "#cc6666",
	lightred = "#E8ACAC",
	pink = "#f4f54d",
	green = "#94c794",
	yellow_bright = "#f5fc7f",
	yellow = "#f7fc9b",
	yellow_light = "#f9fcb3",
	blue = "#81a2be",
	blue_dark = "#486F82",
	blue_dark_dark = "#3E5366",
	teal = "#93E4E2",
	popblue = "#51a7b0",
	pigeon = "#93AEDD",
	aqua = "#8bb88a",
	cyan = "#8bb3ad",
	purple = "#9177b5",
	violet = "#C3A3D1",
	orange = "#db956a",
	ochre = "#e2847a",
	brown = "#a3685a",
	seagreen = "#698b69",
	turquoise = "#698b69",
	statusline_bg = "#81a2be",
	fg = "#e0e0e0",
	fg_dark = "#9a9a9a",
	bg = "#282c34",
	bg_light = "#333842",
	border = "#393E47",
	comment = "#797B80",
	comment_dark = "#4F535B",
	NvimLightGrey3 = "#C4C6CD",
	bg_dark = "#26292E",
	bg_darker = "#141518",
	term_bg = "#23262B",
	tex_command = "#c586c0",
	tex_env = "#93E4E2",
	tex_arg = "#9cdcfe",
	tex_math = "#b5cea8",
	tex_label = "#dcdcaa",
	tex_comment = "#6a9955",
	tex_special = "#d16969",
}

hi("Normal", { fg = c.fg, bg = c.bg })
hi("TerminalNormal", { fg = c.NvimLightGrey3, bg = c.term_bg })
hi("LineNr", { fg = c.fg_dark, bg = c.bg_dark })
hi("CursorLine", { bg = c.bg_light })
hi("CursorLineNr", { fg = c.fg, bg = c.bg_dark, style = "bold" })
hi("Conceal", { fg = c.ochre, bg = c.bg })
hi("Comment", { fg = c.comment, style = "italic" })
hi("WinSeparator", { fg = c.NvimLightGrey3 })
hi("MatchParen", { fg = c.yellow, bg = c.gray1, style = "bold" })
hi("EndOfBuffer", { fg = c.bg, style = "none" })
hi("ModeMsg", { fg = c.teal, style = "none" })
hi("Bold", { fg = c.superwhite, style = "bold" })
hi("Visual", { bg = c.blue_dark, style = "none" })
hi("VisualNonText", { bg = c.blue_dark, fg = c.fg_dark, style = "none" })
hi("Title", { fg = c.green, style = "bold" })

hi("Pmenu", { bg = c.gray1 })
hi("PmenuSel", { bg = c.yellow, fg = c.bg })
hi("PmenuThumb", { bg = c.comment_dark })
hi("NormalFloat", { bg = c.bg_darker })
hi("FloatBorder", { bg = c.bg_darker, fg = c.bg_darker })
hi("FloatTitle", { bg = c.bg_darker, fg = c.green })

hi("Tabline", { fg = c.blue, bg = c.comment_dark })
hi("TablineFill", { bg = c.fg_dark })
hi("TablineSel", { fg = c.fg, bg = c.bg, style = "bold" })

hi("Winbar", { fg = c.NvimLightGrey3, bg = c.bg, style = "none" })
hi("WinbarNC", { fg = c.comment_dark, bg = c.bg, style = "none" })

hi("StatusLine", { fg = c.border, bg = c.statusline_bg })
hi("StatusLineNc", { fg = c.fg_dark, bg = c.gray1 })
hi("StatusLineHeader", { fg = c.border, bg = c.statusline_bg, style = "none" })
hi("StatusLineHeaderNC", { fg = c.comment, bg = c.bg, style = "none" })
hi("StatusLineHeaderNorm", { fg = c.yellow, bg = c.bg, style = "bold" })
hi("StatusLineHeaderCmd", { fg = c.orange, bg = c.bg, style = "bold" })
hi("StatusLineHeaderTerm", { fg = c.superwhite, style = "bold" })
hi("StatusLinePos", { fg = c.bg, bg = c.blue })
hi("StatusLineLsp", { link = "StatusLinePos" })
hi("StatusLineBufName", { fg = c.superwhite, style = "bold" })

hi("DiagnosticUnderlineError", { fg = c.red, style = "undercurl" })
hi("DiagnosticUnderlineWarn", { sp = c.yellow_light, style = "undercurl" })
hi("DiagnosticUnderlineInfo", { sp = c.blue, style = "undercurl" })
hi("DiagnosticUnderlineeHint", { sp = c.aqua, style = "undercurl" })
hi("DiagnosticUnderlineeOk", { sp = c.green, style = "undercurl" })
hi("DiagnosticUnnecessary", { style = "none" })

hi("LspReferenceText", { bg = c.blue_dark_dark, style = "none" })
hi("LspReferenceRead", { bg = c.blue_dark_dark, style = "none" })
hi("LspReferenceWrite", { bg = c.blue_dark_dark, style = "none" })

hi("SpellBad", { sp = c.red, style = "undercurl" })
hi("SpellLocal", { sp = c.red, style = "undercurl" })
hi("SpellRare", { sp = c.red, style = "undercurl" })
hi("SpellCap", { sp = c.red, style = "undercurl" })

hi("TelescopeMatching", { fg = c.orange, style = "bold" })
hi("TelescopeSelection", { bg = c.yellow, fg = c.bg })
hi("TelescopeSelectionCaret", { fg = c.bg, bg = c.yellow })

hi("BlinkCmpLabelMatch", { fg = c.ochre, style = "bold" })
hi("BlinkCmpKind", { fg = c.blue })
hi("BlinkCmpMenuSelection", { fg = c.bg, bg = c.yellow, style = "none" })
hi("BlinkCmpGhostText", { fg = c.comment })

hi("TreesitterContext", { bg = c.border })
hi("TreesitterContextLineNumber", { fg = c.blue, bg = c.border })

hi("@comment", { link = "Comment" })
hi("@comment.todo", { fg = c.bg, bg = c.blue, style = "bold" })
hi("Todo", { fg = c.bg, bg = c.blue, style = "bold" })

hi("@constant", { fg = c.orange, style = "none" })
hi("@boolean", { fg = c.orange, style = "none" })
hi("Number", { fg = c.red, style = "none" })
hi("@string", { fg = c.green })

hi("@function", { fg = c.yellow, style = "none" })
hi("@function.method", { fg = c.yellow, style = "none" })
hi("@function.call", { fg = c.blue, style = "none" })
hi("@function.method.call", { fg = c.blue, style = "none" })
hi("@function.bracket", { fg = c.fg, bg = c.bg })

hi("@keyword", { fg = c.violet, style = "none" })
hi("@keyword.conditional", { fg = c.ochre, style = "none" })
hi("@keyword.function", { fg = c.violet, style = "none" })
hi("@keyword.faded", { fg = c.comment, style = "none" })
hi("@keyword.repeat", { fg = c.ochre, style = "none" })
hi("@keyword.return", { fg = c.violet, style = "italic" })
hi("@keyword.exception", { fg = c.blue, style = "none" })
hi("@keyword.operator", { fg = c.lightred, style = "none" })
hi("@keyword.import", { fg = c.cyan, style = "none" })
hi("@keyword.import.latex", { fg = c.yellow, style = "none" })

hi("@type.builtin", { fg = c.violet, style = "bold" })

hi("@module", { fg = c.fg })
hi("@module.builtin", { fg = c.blue, style = "bold" })
hi("@module.latex", { fg = c.blue })

hi("@property", { fg = c.blue })

hi("@variable", { fg = c.superwhite })
hi("@variable.builtin", { fg = c.violet, bg = c.bg })
hi("@variable.member", { fg = c.blue })
hi("@variable.parameter", { fg = c.pigeon })

hi("@constructor", {})

hi("@punctuation", { fg = c.white })
hi("@punctuation.bracket", { fg = c.white })
hi("@punctuation.special", { fg = c.violet })

hi("@variable.builtin.python", { fg = c.red })
hi("@type.python", { fg = c.yellow })

hi("texEnvArgName", { fg = c.blue })
hi("texCmd", { fg = c.tex_command })
hi("texBeginEnd", { fg = c.tex_env })
hi("texArg", { fg = c.tex_arg })
hi("texMath", { fg = c.tex_math })
hi("texRefZone", { fg = c.tex_label })
hi("texComment", { fg = c.tex_comment, style = "italic" })
hi("texDelim", { fg = c.tex_special })
hi("texSection", { fg = c.tex_command, style = "bold" })
hi("texStatement", { fg = c.tex_command })
hi("texFileOpt", { fg = c.tex_special })
hi("texEnvOpt", { fg = c.tex_math })
