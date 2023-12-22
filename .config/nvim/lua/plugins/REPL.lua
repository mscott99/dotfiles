-- return {}
-- Stuff below causes errors!

local function start_julia_repl()
  vim.cmd([[Tnew]])
  vim.cmd([[1T julia --project]])
end

-- local trim_spaces = true

-- vim.keymap.set("v", "<space>s", function()
--   require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
-- end)
-- vim.keymap.set("v", "<space>r", function()
--     require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })end)
--
-- Replace with these for the other two options
-- require("toggleterm").send_lines_to_terminal("visual_line", trim_spaces, { args = vim.v.count })
-- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

vim.keymap.set("n", "<leader>R", "<cmd>TermExec cmd='ipython --no-autoindent'<cr>", { desc = "start repl" })
vim.keymap.set("n", "<leader>r", "<cmd>ToggleTermSendCurrentLine<cr>j", { desc = "send line to REPL" })
-- vim.keymap.set("v", "<leader>r", "<cmd>ToggleTermSendVisualLines<cr>j", { desc = "send selection to REPL" })
local trim_spaces = false
vim.keymap.set("v", "<leader>r", function()
    require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
end)


-- function(args) M.send_lines_to_terminal("visual_lines", true, args) end
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  },
    -- config = function()
    -- end,
  -- { -- REPL for Julia
  --   "kassio/neoterm",
  --   -- event = "VeryLazy",
  --   ft = { "python", "julia" },
  --   -- event = "BufEnter *.jl",
  --   -- this next line breaks lua syntax highlighting, but is needed for it to work.
  --   -- ft = { "julia" },
  --   config = function()
  --     -- vim.cmd([[set nocompatible]])
  --     -- vim.cmd([[filetype off]])
  --
  --     -- vim.cmd([[let &runtimepath.=',~/.vim/bundle/neoterm']])
  --
  --     -- Enable below for python
  --     -- vim.g.neoterm_repl_python = { "source ./myenv/bin/activate", "ipython" }
  --     -- vim.g.neoterm_repl_command = "julia --project"
  --     -- vim.g.neoterm_default_mod = "belowright"
  --     --
  --     -- test the line below
  --
  --     vim.g.neoterm_default_mod = "belowright"
  --     vim.g.neoterm_size = 16
  --     vim.g.neoterm_autoscroll = 1
  --     vim.keymap.set("n", "<leader>r", "<cmd>TREPLSendLine<cr>j")
  --     vim.keymap.set("n", "<leader>R", start_julia_repl)
  --     vim.keymap.set("n", "<leader>t", "Vip:TREPLSendLine<cr>}")
  --     vim.keymap.set("v", "<leader>r", "<cmd>TREPLSendSelection<cr>j")
  --     vim.keymap.set("i", "<C-d>", "<cmd>TREPLSendSelection<cr>")
  --   end,
  -- },
}
