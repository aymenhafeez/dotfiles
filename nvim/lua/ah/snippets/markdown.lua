local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	-- Section
	s({
		trig = "s",
		dscr = "Section",
		wordTrig = true,
	}, {
		t "# ",
		i(1, "Section Name"),
		t " #",
		t { "", "" },
		i(0),
	}),

	-- Sub Section
	s({
		trig = "ss",
		dscr = "Sub Section",
		wordTrig = true,
	}, {
		t "## ",
		i(1, "Section Name"),
		t " ##",
		t { "", "" },
		i(0),
	}),

	-- SubSub Section
	s({
		trig = "sss",
		dscr = "SubSub Section",
		wordTrig = true,
	}, {
		t "### ",
		i(1, "Section Name"),
		t " ###",
		t { "", "" },
		i(0),
	}),

	-- Paragraph
	s({
		trig = "par",
		dscr = "Paragraph",
		wordTrig = true,
	}, {
		t "#### ",
		i(1, "Paragraph Name"),
		t " ####",
		t { "", "" },
		i(0),
	}),

	-- Sub Paragraph
	s({
		trig = "spar",
		dscr = "Sub Paragraph",
		wordTrig = true,
	}, {
		t "##### ",
		i(1, "Paragraph Name"),
		t " #####",
		t { "", "" },
		i(0),
	}),

	-- Link
	s({
		trig = "link",
		dscr = "Link to something",
		wordTrig = true,
	}, {
		t "[",
		i(1, "Text"),
		t "](",
		i(2),
		t ")",
		i(0),
	}),

	-- Image
	s({
		trig = "img",
		dscr = "Image",
		wordTrig = true,
	}, {
		t "![",
		i(1, "pic alt"),
		t "](",
		i(2, "path"),
		f(function(args)
			return args[1][1] ~= "" and ' "' or ""
		end, { 3 }),
		i(3, "opt title"),
		f(function(args)
			return args[1][1] ~= "" and '"' or ""
		end, { 3 }),
		t ")",
		i(0),
	}),

	s({ trig = "bf", dscr = "bold text", wordTrig = true }, fmta([[**<>**<>]], { i(1), i(0) })),
	s({ trig = "it", dscr = "italic text", wordTrig = true }, fmta([[*<>*<>]], { i(1), i(0) })),
}
