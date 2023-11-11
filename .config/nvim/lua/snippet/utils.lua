local M = {}
local ts = require("vim.treesitter")
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.get_visual(args, parent) -- use with dynamic node d(1, get_visual)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

function M.map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

function M.concat(tables)
  local v = {}
  for key, value in pairs(tables) do
    vim.list_extend(v, value)
  end
  return v
end

local function check_in_mathzone()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col - 1
  parser = ts.get_parser(buf)
  parser:parse()
  return parser:children()["markdown_inline"]:children()["latex"]:contains({row,col, row, col})
end

-- -- caching, but maybe not necessary
-- vim.api.nvim_create_autocmd({ "BufNew", "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.md", "*.tex" },
--   callback = function()
--     if not vim.b.tracking_math then
--       vim.api.nvim_buf_attach(0, false, {
--         on_lines = function(...)
--           vim.b.in_mathzone = check_in_mathzone()
--         end,
--       })
--       vim.b.in_mathzone = false
--       vim.b.tracking_math = true
--     end
--   end,
-- })
--
function M.in_markdown_mathzone()
  return check_in_mathzone()
  -- return vim.b.in_mathzone
end

function M.not_in_markdown_mathzone()
  return not check_in_mathzone()
  -- return not vim.b.in_mathzone
end

function M.in_tex_mathzone()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

function M.not_in_tex_mathzone()
  return not vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return M

