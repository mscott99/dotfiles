-- return {}
-- Stuff below causes errors!

local function start_julia_repl()
  vim.cmd([[Tnew]])
  vim.cmd([[1T julia --project]])
end

return {
  { -- REPL for Julia
    "kassio/neoterm",
    -- event = "VeryLazy",
    -- ft = { "python", "julia" },
    event = "BufEnter *.jl",
    -- this next line breaks lua syntax highlighting, but is needed for it to work.
    -- ft = { "julia" },
    config = function()
      -- vim.cmd([[set nocompatible]])
      -- vim.cmd([[filetype off]])

      -- vim.cmd([[let &runtimepath.=',~/.vim/bundle/neoterm']])

      -- Enable below for python
      -- vim.g.neoterm_repl_python = { "source ./myenv/bin/activate", "ipython" }
      vim.g.neoterm_repl_command = "julia --project"
      -- vim.g.neoterm_default_mod = "belowright"
      --
      -- test the line below

      vim.g.neoterm_default_mod = "belowright"
      vim.g.neoterm_size = 16
      vim.g.neoterm_autoscroll = 1
      vim.keymap.set("n", "<leader>r", "<cmd>TREPLSendLine<cr>j")
      vim.keymap.set("n", "<leader>R", start_julia_repl)
      vim.keymap.set("n", "<leader>t", "Vip:TREPLSendLine<cr>}")
      vim.keymap.set("v", "<leader>r", "<cmd>TREPLSendSelection<cr>j")
      vim.keymap.set("i", "<C-d>", "<cmd>TREPLSendSelection<cr>")
    end,
  },
}
