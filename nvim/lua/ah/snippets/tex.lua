local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- helper function to check if in a math context
local function in_mathzone()
	-- check if vimtex is available
	if vim.fn.exists "*vimtex#syntax#in_mathzone" == 1 then
		return vim.fn["vimtex#syntax#in_mathzone"]() == 1
	end
	return false
end

-- helper to create conditional snippets
local function get_visual(_args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end

return {
	s(
		{ trig = "beg", dscr = "begin{} / end{}", wordTrig = true },
		fmta(
			[[
\begin{<>}
	<>
\end{<>}
]],
			{
				i(1),
				d(2, get_visual),
				rep(1),
			}
		)
	),

	s(
		{ trig = "ali", dscr = "aligned numbered equation", wordTrig = true },
		fmta(
			[[
\begin{align}
	<>
\end{align}
]],
			{ d(1, get_visual) }
		)
	),

	-- gather
	s(
		{ trig = "gat", dscr = "gather", wordTrig = true },
		fmta(
			[[
\begin{gather}
	<>
\end{gather}
]],
			{ d(1, get_visual) }
		)
	),

	s(
		{ trig = "ngat", dscr = "gather without numbering", wordTrig = true },
		fmta(
			[[
\begin{gather*}
	<>
\end{gather*}
]],
			{ d(1, get_visual) }
		)
	),

	s(
		{ trig = "nali", dscr = "aligned unnumbered equation", wordTrig = true },
		fmta(
			[[
\begin{align*}
	<>
\end{align*}
]],
			{ d(1, get_visual) }
		)
	),

	s(
		{ trig = "itm", dscr = "begin itemize", wordTrig = true },
		fmta(
			[[
\begin{itemize}
	\item <>
\end{itemize}
]],
			{ d(1, get_visual) }
		)
	),

	s(
		{ trig = "itm-", dscr = "begin itemize with arrow bullet", wordTrig = true },
		fmta(
			[[
\begin{itemize}
	\item[\(\to\)] <>
\end{itemize}
]],
			{ d(1, get_visual) }
		)
	),

	s({ trig = "otm", dscr = "item with bullet option", wordTrig = true }, fmta([[\item[<>] <>]], { i(1), i(0) })),

	s(
		{ trig = "enu", dscr = "begin enumerate", wordTrig = true },
		fmta(
			[[
\begin{enumerate}
	\item <>
\end{enumerate}
]],
			{ d(1, get_visual) }
		)
	),

	s({ trig = "im", dscr = "inline mathzone", wordTrig = true }, {
		t "\\(",
		i(1),
		t "\\)",
		f(function(_args, snip)
			-- Check if there's a next character and if it needs spacing
			local next_char = snip.env.POSTFIX or ""
			if next_char ~= "" and not next_char:match "^[,%.%?%- ]" then
				return " "
			else
				return ""
			end
		end),
		i(0),
	}),

	-- display mathzone
	s(
		{ trig = "mm", dscr = "math", wordTrig = true },
		fmta(
			[[
\[
	<>
\] <>
]],
			{ d(1, get_visual), i(0) }
		)
	),

	s({ trig = "^", dscr = "auto expand superscript", wordTrig = false }, fmta("^{<>}<>", { i(1), i(0) })),

	s(
		{ trig = "int", dscr = "integral", wordTrig = true },
		fmta([[\int_{<>}^{<>} <> \dd <>]], { i(1), i(2, "\\infty"), d(3, get_visual), i(0) })
	),

	s(
		{ trig = "dint", dscr = "infinite integral", wordTrig = true },
		fmta([[\int_{<>}^{<>} <> <> \dd <>]], { i(1, "-\\infty"), i(2, "\\infty"), d(3, get_visual), i(4), i(0) })
	),

	s({ trig = "lim", dscr = "limit", wordTrig = true }, fmta([[\lim_{<> \to <>} ]], { i(1, "n"), i(2, "\\infty") })),

	s(
		{ trig = "sum", dscr = "summation", wordTrig = true },
		fmta([[\sum_{<>}^{<>} <>]], { i(1, "n=1"), i(2, "\\infty"), i(3, "a_n z^n") })
	),

	s({ trig = "sm", dscr = "short summation", wordTrig = true }, fmta([[\sum_{<>}<>]], { i(1, "n>0"), i(0) })),

	s(
		{ trig = "prod", dscr = "product", wordTrig = true },
		fmta([[\prod_{<>=<>}^{<>} <> <>]], { i(1, "n"), i(2, "1"), i(3, "\\infty"), d(4, get_visual), i(0) })
	),

	s({ trig = "prd", dscr = "short product", wordTrig = true }, fmta([[\prod_{<>}<>]], { i(1), i(0) })),

	s(
		{ trig = "od", dscr = "ordinary derivative", wordTrig = true },
		fmta([[\frac{\dd <>}{\dd <>}<>]], { i(1), i(2), i(0) })
	),

	s(
		{ trig = "sod", dscr = "second order ordinary derivative", wordTrig = true },
		fmta([[\frac{\dd^2 <>}{\dd <>^2}<>]], { i(1), i(2), i(0) })
	),

	s(
		{ trig = "pd", dscr = "partial derivative", wordTrig = true },
		fmta([[\frac{\partial <>}{\partial <>}<>]], { i(1), i(2), i(0) })
	),

	s(
		{ trig = "spd", dscr = "second order partial derivative", wordTrig = true },
		fmta([[\frac{\partial^2 <>}{\partial <>^2}<>]], { i(1), i(2), i(0) })
	),

	s({ trig = "ubr", dscr = "underbrace", wordTrig = true }, fmta([[\underbrace{<>}]], { d(1, get_visual) })),

	s(
		{ trig = "sqr", dscr = "squareroot", wordTrig = false, condition = in_mathzone },
		fmta([[\sqrt{<>} <>]], { d(1, get_visual), i(0) })
	),

	s({ trig = "tx", dscr = "text in math environment", wordTrig = true }, fmta([[\text{<>}<>]], { i(1), i(0) })),

	s({ trig = "frac", dscr = "fraction", wordTrig = true }, fmta([[\frac{<>}{<>}<>]], { i(1), i(2), i(0) })),

	s(
		{ trig = "num", dscr = "make visual selection the numerator of a fraction", wordTrig = true },
		fmta([[\frac{<>}{<>}<>]], { d(1, get_visual), i(2), i(0) })
	),

	s(
		{ trig = "den", dscr = "make visual selection the denominator of a fraction", wordTrig = true },
		fmta([[\frac{<>}{<>}<>]], { i(1), d(2, get_visual), i(0) })
	),

	s({ trig = "\\oo", dscr = "infinity", wordTrig = false }, t "\\infty"),

	s({ trig = "to", dscr = "to", wordTrig = false }, t "\\(\\to\\)"),

	s({ trig = "=>i", dscr = "implies", wordTrig = false }, t "\\implies"),

	s({ trig = "=<", dscr = "implied by", wordTrig = false }, t "\\impliedby"),

	s({ trig = "th", dscr = "therefore", wordTrig = true }, t "$\\therefore$ "),

	s({ trig = "ap", dscr = "approx", wordTrig = true }, t "$\\approx$"),

	-- iff in mathenv
	s({ trig = "iff", dscr = "iff", wordTrig = true, condition = in_mathzone }, t "\\iff"),

	s(
		{ trig = "l(", dscr = "left( right)", wordTrig = false, condition = in_mathzone },
		fmta([[\left( <> \right) <>]], { d(1, get_visual), i(0) })
	),

	s(
		{ trig = "l[", dscr = "square brackets", wordTrig = false, condition = in_mathzone },
		fmta([[\left[ <> \right] <>]], { d(1, get_visual), i(0) })
	),

	s(
		{ trig = "l{", dscr = "curly brackets", wordTrig = false, condition = in_mathzone },
		fmta([[\left\{ <> \right\} <>]], { d(1, get_visual), i(0) })
	),

	-- leftangle rightangle in mathenv (causing some issues)
	-- s(
	-- 	{ trig = "l<", dscr = "leftangle rightangle", wordTrig = false, condition = in_mathzone },
	-- 	fmta([[\left<<> \right><>]], { d(1, get_visual), i(0) })
	-- ),

	s(
		{ trig = "lng", dscr = "langle rangle", wordTrig = false },
		fmta([[\langle <> \rangle<>]], { d(1, get_visual), i(0) })
	),

	s({ trig = "bar", dscr = "bar", wordTrig = true }, fmta([[\overline{<>}<>]], { i(1), i(0) })),

	s({ trig = "hat", dscr = "hat", wordTrig = true }, fmta([[\hat{<>}<>]], { i(1), i(0) })),

	s({ trig = "bf", dscr = "bold text", wordTrig = true }, fmta([[\textbf{<>}<>]], { i(1), i(0) })),

	s({ trig = "it", dscr = "italic text", wordTrig = true }, fmta([[\textit{<>}<>]], { i(1), i(0) })),

	s({ trig = "ttt", dscr = "inline code", wordTrig = true }, fmta([[\texttt{<>}<>]], { i(1), i(0) })),

	s({ trig = "itbf", dscr = "bold, italic text", wordTrig = true }, fmta([[\textit{\textbf{<>}}<>]], { i(1), i(0) })),

	s({ trig = "ul", dscr = "underlined text", wordTrig = true }, fmta([[\underline{<>}<>]], { i(1), i(0) })),

	s({ trig = "...", dscr = "ldots", wordTrig = false }, t "\\ldots"),

	s({ trig = "c.", dscr = "cdot", wordTrig = true }, t "\\cdot"),

	s({ trig = "c..", dscr = "cdots", wordTrig = true }, t "\\cdots"),

	s({ trig = "v..", dscr = "vdots", wordTrig = true }, t "\\vdots"),

	s({ trig = "box", dscr = "boxed", wordTrig = true }, fmta([[\boxed{<>}<>]], { d(1, get_visual), i(0) })),

	s(
		{ trig = "pmat", dscr = "pmatrix", wordTrig = true },
		fmta(
			[[
\begin{pmatrix}
	<>
\end{pmatrix} <>
]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "sec", dscr = "section with choice (cycle with Ctrl-l)", wordTrig = true },
		fmta(
			[[
     \<>{<>}

     <>
     ]],
			{
				c(1, {
					t "section*",
					t "subsection*",
					t "subsubsection*",
				}),
				i(2),
				i(0),
			}
		)
	),

	--   s(
	--     { trig = "sec", dscr = "section without number", wordTrig = true },
	--     fmta(
	--       [[
	-- \section*{<>}
	--
	-- <>
	-- ]],
	--       { i(1), i(0) }
	--     )
	--   ),
	--
	--   s(
	--     { trig = "ssec", dscr = "sub section without number", wordTrig = true },
	--     fmta(
	--       [[
	-- \subsection*{<>}
	--
	-- <>
	-- ]],
	--       { i(1), i(0) }
	--     )
	--   ),
	--
	--   s(
	--     { trig = "sssec", dscr = "sub sub section without number", wordTrig = true },
	--     fmta(
	--       [[
	-- \subsubsection*{<>}
	--
	-- <>
	-- ]],
	--       { i(1), i(0) }
	--     )
	--   ),

	s(
		{ trig = "sct", dscr = "numbered section", wordTrig = true },
		fmta(
			[[
\section{<>}

<>
]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "ssct", dscr = "numbered sub section", wordTrig = true },
		fmta(
			[[
\subsection{<>}

<>
]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "sssct", dscr = "numbered sub sub section", wordTrig = true },
		fmta(
			[[
\subsubsection{<>}

<>
]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "incg", dscr = "include basic graphic", wordTrig = true },
		fmta(
			[[
\includegraphics[width=<>\textwidth]{<>}
<>
]],
			{ i(1), i(2), i(0) }
		)
	),

	-- figure
	s(
		{ trig = "fig", dscr = "figure", wordTrig = true },
		fmta(
			[[

\begin{figure}[H]
	\centering
	\includegraphics[width=<>\textwidth]{<>}
	\caption{<>}
\end{figure}
<>
]],
			{ i(1), i(2), i(3), i(0) }
		)
	),

	s(
		{ trig = "2subfig", dscr = "figure with two subfigures", wordTrig = true },
		fmta(
			[[

\begin{figure}[H]
	\centering
	\begin{subfigure}[b]{<>\linewidth}
	\includegraphics[width=\linewidth]{<>} 
	\caption{<>}
	\end{subfigure}\vspace{5mm}
	\centering
	\begin{subfigure}[b]{<>\linewidth}
	\includegraphics[width=\linewidth]{<>}
	\caption{<>}
	\end{subfigure}
	\caption{<>}
\end{figure}
<>
]],
			{ i(1), i(2, "fig_path"), i(3), i(4), i(5, "fig_path"), i(6), i(7), i(0) }
		)
	),

	s(
		{ trig = "3subfig", dscr = "figure with three subfigures", wordTrig = true },
		fmta(
			[[
\begin{figure}[H]
	\centering
	\begin{subfigure}[b]{<>\linewidth}
	\includegraphics[width=\linewidth]{<>} 
	\caption{<>}
	\end{subfigure}\hspace{5mm}
	\centering
	\begin{subfigure}[b]{<>\linewidth}
	\includegraphics[width=\linewidth]{<>}
	\caption{<>}
	\end{subfigure}\hspace{5mm}
	\centering
	\begin{subfigure}[b]{<>\linewidth}
	\includegraphics[width=\linewidth]{<>}
	\caption{<>}
	\end{subfigure}
	\caption{<>}
\end{figure}
<>
]],
			{
				i(1),
				i(2, "fig_path"),
				i(3),
				i(4),
				i(5, "fig_path"),
				i(6),
				i(7),
				i(8, "fig_path"),
				i(9),
				i(10),
				i(0),
			}
		)
	),

	s(
		{ trig = "table", dscr = "table environment", wordTrig = true },
		fmta(
			[[
\begin{table}[<>]
	\centering
	\caption{<>}
	\label{tab:<>}
	\begin{tabular}{<>}
	<>
	\end{tabular}
\end{table}
]],
			{ i(1, "htpb"), i(2, "caption"), i(3, "label"), i(4, "c"), i(0) }
		)
	),

	s(
		{ trig = "href", dscr = "link to url", wordTrig = true },
		fmta([[\href{<>}{<>} <>]], { i(1, "url"), i(2, "text to display"), i(0) })
	),

	s({ trig = "sch", dscr = "Schrodinger", wordTrig = true }, fmta([[Schr\"{o}dinger <>]], { i(0) })),

	s(
		{ trig = "begindoc", dscr = "create basic template", wordTrig = true },
		fmta(
			[[
\documentclass[12pt]{article}

\usepackage[margin=2.0cm]{geometry}    %changes margin size
\usepackage{graphicx} % for adding pictures
\usepackage{float} %for positioning pictures
\usepackage{gensymb}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{chngcntr}
\usepackage{hyperref}
\usepackage{subcaption}
\usepackage{listings}
\usepackage{algorithm}
\usepackage{algorithmic}
\usepackage[most]{tcolorbox}
\setlength{\parindent}{0pt}

\newcommand{\dd}{\mathrm{d}}
\newcommand{\R}{\mathrm{R}}
\newcommand{\C}{\mathrm{C}}
\newcommand{\Z}{\mathrm{Z}}
\newcommand{\Q}{\mathrm{Q}}
\newcommand{\prob}{\mathrm{P}}
\newcommand{\code}[1]{\texttt{#1}}
\newcommand*\mean[1]{\bar{#1}}

\DeclareMathOperator*{\minimize}{minimize}

\newtcblisting{codeblock}{
  colback=gray!10,
  colframe=gray!40,
  listing only,
  listing options={basicstyle=\ttfamily\small, mathescape},
  left=4pt, right=4pt, top=4pt, bottom=4pt,
  arc=2mm,
  boxrule=0pt,
}

\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]

\begin{document}

\begin{huge}
	<>
\end{huge}

\section*{<>}

<>

\end{document}
]],
			{ i(1), i(2), i(0) }
		)
	),
}
