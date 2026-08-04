local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- Condition: only expand in math mode (requires VimTeX)
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
   s(
      {
	 trig = " ff ",
	 snippetType = "autosnippet",
	 condition = in_mathzone,
      },
      { fmta("\\frac{<>}{<>}", { i(1), i(2) }) }
   ),
}

