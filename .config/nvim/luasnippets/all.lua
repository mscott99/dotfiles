local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local get_visual = require("snippet.utils").get_visual
return {
    s({ trig = "(", wordTrig = false, priority = 200, snippetType = "autosnippet" }, fmta([[(<>)]], { d(1, get_visual) })),
    s({ trig = "[", wordTrig = false, priority = 200, snippetType = "autosnippet" }, fmta("[<>]", { d(1, get_visual) })),
    s({ trig = "{", wordTrig = false, priority = 200, snippetType = "autosnippet" }, fmta("{<>}", { d(1, get_visual) })),
}
