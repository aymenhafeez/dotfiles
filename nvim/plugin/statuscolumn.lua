-- _G.statuscolumn = function()
-- 	return table.concat {
-- 		-- Your line numbers
-- 		vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum,
-- 		-- Spacing
-- 		" ",
-- 		-- Gitsigns
-- 		vim.F.npcall(function()
-- 			return require("gitsigns").statuscolumn()
-- 		end) or "",
-- 	}
-- end
--
-- vim.opt.statuscolumn = "%s%=%{%v:lua.statuscolumn()%}"

require("statuscol").setup {
	relculright = true,
	segments = {
		{ text = { require("statuscol.builtin").foldfunc }, click = "v:lua.ScFa" },
		{ text = { require("statuscol.builtin").lnumfunc }, click = "v:lua.ScLa" },
		{ text = { " " } },
		{
			sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2, auto = false, fillchar = " " },
			click = "v:lua.ScSa",
		},
	},
}
