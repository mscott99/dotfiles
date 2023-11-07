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
      { trig = "align", wordTrig = true, name = "align", condition = not_math},
      { t({"$$", "\\begin{"}), i(1, "align*"), t({"}", "  "}), i(2, " "), t({"", "\\end{"}), rep(1), t({"}", "$$"})}
    ),
    s(
      { trig = "fal", wordTrig = true, name = "first align", describe = "[F]irst [Al]ign", condition = is_math, snippetType = "autosnippet"},
      { i(1, "A"), t(" &"), i(2, "="), t(" "), i(3, "B"), t({" \\\\", ""})}
    ),
    s(
      { trig = "nal", wordTrig = true, name = "next align", describe = "[F]irst [Al]ign", condition = is_math, snippetType = "autosnippet"},
      { t(" &"), i(1, "="), t(" "), i(2, "B"), t({" \\\\", ""})}
    ),
    s(
      { trig = "int", wordTrig = true, name = "integral", condition = is_math },
      fmta([[\int_{<>}^{<>} <> d<>]], { i(1, "x=0"), i(2, "\\infty"), i(3, "f(x)"), i(4, "x") })
    ),
    s(
      { trig = "vecs", wordTrig = true, name = "vectors", condition = not_math },
      fmta([[$<>_1, \ldots, <>_<>$]], { i(1, "a"), rep(1), i(2, "l")})
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
