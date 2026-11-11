local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

local function get_visual(_args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {
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

  s(
    { trig = "mm", dscr = "math", wordTrig = true },
    fmta(
      [[
$$
	<>
$$<>
]],
      { d(1, get_visual), i(0) }
    )
  ),

  s({ trig = "im", dscr = "inline mathzone", wordTrig = true }, {
    t "$",
    i(1),
    t "$",
    f(function(_args, snip)
      local next_char = snip.env.POSTFIX or ""
      if next_char ~= "" and not next_char:match "^[,%.%?%- ]" then
        return " "
      else
        return ""
      end
    end),
    i(0),
  }),

  s({ trig = "frac", dscr = "fraction", wordTrig = true }, fmta([[\frac{<>}{<>}<>]], { i(1), i(2), i(0) })),


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
