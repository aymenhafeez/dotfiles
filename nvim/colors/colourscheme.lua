local lighter = require("utils").lighter
local darker = require("utils").darker
local mod = require("utils").modify_colour
local bg = "#282c34"

local highlights = {
	Normal = { fg = "NvimLightGrey2", bg = bg },
	Statusline = { bg = mod(bg, 40) },
	StatuslineNC = { bg = mod(bg, 40) },
	CursorLine = { bg = mod(bg, 20) },
	NormalFloat = { bg = bg },
	Pmenu = { bg = bg },
	PmenuBorder = { link = "Comment" },
	BlinkCmpMenuBorder = { link = "PmenuBorder" },
	WinSeparator = { fg = mod(bg, -25) },
	Statement = { fg = "NvimLightBlue" },
	SpellBad = { undercurl = true },
	Comment = { italic = true },
	PmenuThumb = { bg = "NvimLightGrey1" },
	QuickFixLine = { fg = "None", bg = "NvimDarkCyan" },
	TablineSel = { bg = "NvimLightGrey4", fg = "bg" },
	Number = { fg = "NvimLightGrey2", bold = true },
	["@variable.member"] = { fg = "LightBlue" },
	["@keyword"] = { fg = "NvimLightGrey2", bold = true },
	["@keyword.function"] = { fg = "NvimLightBlue" },
	["@module.builtin"] = { fg = "NvimLightYellow" },

	User1 = { fg = "NvimLightRed", bg = mod("#282c34", 40), bold = true },
	User2 = { fg = "LightBlue", bg = mod("#282c34", 40), bold = true },
	User3 = { bg = mod("#282c34", 40), bold = true },
	User4 = { fg = mod("#282c34", 40), bg = "NvimLightYellow" },
	User5 = { fg = "NvimLightYellow", bg = mod("#282c34", 40) },
	User8 = { fg = "fg", bg = mod("#282c34", 100) },
	User9 = { fg = "NvimLightGrey2", bg = mod("#282c34", 40) },
}

for hl_group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, hl_group, opts)
end

local function test()
	print("Hello")
end


test()
