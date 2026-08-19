local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.conditions.expand").line_begin

-- 1. Condition: only expand in math mode (requires VimTeX)
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- 2. Helper for simple math text replacements
local function math_tex(trig, expansion)
  return s(
    { trig = trig, snippetType = "autosnippet", wordTrig = true, condition = in_mathzone },
    t(expansion)
  )
end

-- 3. Greek letters and math symbols
local symbols = {
  alpha  = "\\alpha",
  beta   = "\\beta",
  gamma  = "\\gamma",
  theta  = "\\theta",
  mu     = "\\mu",
  phi    = "\\phi",
  psi    = "\\psi",
  rho    = "\\rho",
  eps    = "\\epsilon",
  veps   = "\\varepsilon",
  ooo    = "\\infty",
  vn     = "\\varnothing",
  xx     = "\\times",
  ["in"] = "\\in",
  nin    = "\\notin",
  fa     = "\\forall",
  cd     = "\\cdot",
  ra     = "\\rightarrow",
  la     = "\\leftarrow",
  iff    = "\\iff",
  dots   = "\\dots",
  ldots  = "\\ldots",
  ss     = "\\subset",
  pss    = "\\subsetneq",
  sseq   = "\\subseteq",
  sus    = "\\superset",
  psus   = "\\supersetneq",
  suseq  = "\\superseteq",
  cup    = "\\cup",
  ccup   = "\\bigcup",
  cap    = "\\cap",
  ccap   = "\\bigcap",
  smin   = "\\setminus",
  setn   = "\\mathbb{N}",
  setz   = "\\mathbb{Z}",
  setq   = "\\mathbb{Q}",
  setr   = "\\mathbb{R}",
  setc   = "\\mathbb{C}",
  imp    = "\\implies",
  neq    = "\\neq",
  leq    = "\\leq",
  geq    = "\\geq",
}

local math_symbols = {}
for trig, sym in pairs(symbols) do
   trig = trig.." " --concatenation
   sym = sym.." " -- concatentaion so it doens't replace the space beforehand (that's ugly)
  table.insert(math_symbols, math_tex(trig, sym))
end

-- Environments & complex snippets
local environments = {
  s( {
      trig = "beg ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{<>}
      <> 
      \end{<>}
      ]],
      { i(1), i(2), rep(1) })),
  s( {
      trig = "sec ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \section{<>}
      \label{sec:<>}


      ]],
      { i(1), rep(1) })),
  s( {
      trig = "sub ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \subsection{<>}
      \label{sec:<>}

      <>
      ]],
      { i(1), rep(1), i(2) })),
  s( {
      trig = "subsub ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \subsubsection{<>}
      \label{sec:<>}

      <>
      ]],
      { i(1), rep(1), i(2) })),
  s( {
      trig = "dm ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \[
      <>
      \]
      ]],
      { i(1) })),
  s( {
      trig = ".im ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = not in_mathzone,
    },
    fmta("\\( <> \\) <>",
      { i(1), i(2) })),
  s( {
      trig = "eq ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{equation}
      <>
      \end{equation}
      ]],
      { i(1) })),
  s( {
      trig = "eqa ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{equation*}
      <>
      \end{equation*}
      ]],
      { i(1) })),
  s( {
      trig = "ali ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{equation}
      \begin{aligned}
      <>
      \end{aligned}
      \end{equation}
      ]],
      { i(1) })),
  s( {
      trig = "ali ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{equation}
      \begin{aligned}
      <>
      \end{aligned}
      \end{equation}
      ]],
      { i(1) })),
  s( {
      trig = "enum ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{enumerate}
      \item <>
      \end{enumerate}
      ]],
      { i(1) })),
  s( {
      trig = "qt ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \begin{quote}
      <>
      \end{quote}
      ]],
      { i(1) })),
}

local templates = {
  s( {
      trig = ".tmp ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = line_begin,
    },
    fmta(
      [[
      \documentclass[11pt,a4paper]{article}

      % Essential packages
      \usepackage[margin=2.5cm]{geometry}
      \usepackage{amsmath, amssymb, amsthm} % Essential math packages
      \usepackage{graphicx}
      \usepackage{hyperref}
      \usepackage{subcaption}
      \usepackage{tablefootnote}
      \usepackage{indentfirst}
      \usepackage{enumitem}
      \usepackage{booktabs} % For nice tables
      \usepackage{bm} % Bold math symbols

      \usepackage{apacite}
      \bibliographystyle{apacite}

      \setlength{\parskip}{0.5em}
      \setlist[enumerate]{nosep, leftmargin=1.5cm}

      \title{<>}
      \author{Luca Boschung}
      \date{\today}

      \begin{document}

      \maketitle

      <>

      
      \bibliography{references}

      \end{document}

      ]],
      { i(1), i(2) })),
}

local formatting = {
  s( {
      trig = "^",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = in_mathzone,
    },
    fmta("^{ <> } <>", { i(1), i(2) })),
  s( {
      trig = "_",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = in_mathzone,
    },
    fmta("_{ <> } <>", { i(1), i(2) })),
  s( {
      trig = "tx ",
      snippetType = "autosnippet",
      wordTrig = false,
      condition = in_mathzone,
    },
    fmta("\\text{<>} <>", { i(1), i(2) })),
  s( {
      trig = ".tb ",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\textbf{<>} <>", { i(1), i(2) })),
  s( {
      trig = ".ti ",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\textit{<>} <>", { i(1), i(2) })),
  s( {
      trig = ".q ",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("``<>\'\' <>", { i(1), i(2) })),
}

local operators = {
  s( {
      trig = "ff ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\frac{ <> }{ <> } <>", { i(1), i(2), i(3) })),
  s( {
      trig = "/ ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\frac{ ${VISUAL} }{ <> } <>", { i(1), i(2) })),
  s( {
      trig = "lim ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\lim_{ <> \\to <> } <> ", { i(1, "n"), i(2, "\\infty"), i(3) })),
  s( {
      trig = "sum ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\sum_{ <> }^{ <> } <>", { i(1, "n=0"), i(2, "\\infty"), i(3) })),
  s( {
      trig = "int ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\int_{ <> }^{ <> } <> d{ <> } <>", { i(1, "-\\infty"), i(2, "\\infty"), i(3), i(4, "x"), i(5) })),
}

local functions = {
  s(
    {
      trig = "sin ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\sin\\left( <> \\right) <>", { i(1), i(2) })
  ),
  s(
    {
      trig = "cos ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\cos\\left( <> \\right) <>", { i(1), i(2) })
  ),
  s(
    {
      trig = "tan ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\tan\\left( <> \\right) <>", { i(1), i(2) })
  ),
  s(
    {
      trig = "e ",
      snippetType = "autosnippet",
      condition = in_mathzone,
    },
    fmta("\\e^{ <> } <>", { i(1), i(2) })
  ),
}

-- 5. Combine and Register
local all_snippets = {}

local function append_snippets(source_table)
  for _, snippet in ipairs(source_table) do
    table.insert(all_snippets, snippet)
  end
end

append_snippets(math_symbols)
append_snippets(environments)
append_snippets(formatting)
append_snippets(operators)
append_snippets(functions)
append_snippets(templates)

ls.add_snippets("tex", all_snippets)
