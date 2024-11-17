local unflattened = {
  require("snippet.math_snippets.frac"),
  require("snippet.math_snippets.greek"),
  require("snippet.math_snippets.hats"),
  require("snippet.math_snippets.large"),
  require("snippet.math_snippets.no_backslash"),
  require("snippet.math_snippets.other"),
  require("snippet.math_snippets.surrounds"),
}

local map = require("snippet.utils").map
local concat = require("snippet.utils").concat

local check_tex_is_math = require("snippet.utils").in_tex_mathzone

local check_tex_is_not_math = function()
  return not check_tex_is_math()
end

local function make_tex_snippet(snip_fn)
    return snip_fn(check_tex_is_math, check_tex_is_not_math)
end

return concat(map(unflattened, make_tex_snippet))
