local lighter = require("utils").lighter
local darker = require("utils").darker
local mod = require("utils").modify_colour
local highlights = {
	Normal = { fg = "NvimLightGrey2", bg = "#282c34" },
	Statusline = { bg = mod("#282c34", 40) },
	StatuslineNC = { bg = mod("#282c34", 40) },
	WinSeparator = { fg = mod("#282c34", -25) },
	SpellBad = { undercurl = true },
	Comment = { italic = true },
	Pmenu = { bg = "NvimDarkGray2" },
	PmenuThumb = { bg = "NvimLightGrey1" },
	NormalFloat = { bg = "bg" },
	QuickFixLine = { fg = "None", bg = "NvimDarkCyan" },
	TablineSel = { bg = "NvimLightGrey4", fg = "bg" },
	Number = { fg = "NvimLightGrey2", bold = true },
	["@variable.member"] = { fg = "LightBlue" },

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
