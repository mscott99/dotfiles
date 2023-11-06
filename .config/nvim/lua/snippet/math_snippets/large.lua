-- -- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return function(is_math, not_math)
  return {
    s(
      { trig = "int", wordTrig = true, name = "integral", condition = is_math },
      fmta([[\int_{<>}^{<>} <> d<>]], { i(1, "x=0"), i(2, "\\infty"), i(3, "f(x)"), i(4, "x") })
    ),

    s(
      { trig = "comb", wordTrig = true, name = "Linear interpolation", condition = is_math },
      { i(1, "\\alpha"), t(" "), i(2, "x"), t(" + (1 - "), rep(1), t(") "), i(3, "y") }
    ),

    -- s({trig = "int", wordTrig=true, name ="integral", condition= is_math},
    --   fmta([[\int_{<>}^{<>} <> d<>]],
    --     {i(1), i(2), rep(1)})),
    --
    s(
      { trig = "beg", wordTrig = true, name = "environment", condition = is_math },
      fmta(
        [[\begin{<>
   <>
\end{<>}]],
        { i(1), i(2), rep(1) }
      )
    ),
  }
end
