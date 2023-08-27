-- return {}
-- Stuff below causes errors!
return {
  { -- REPL for Julia
    "kassio/neoterm",
    -- event = "VeryLazy",
    -- ft = { "python", "julia" },
    -- event = "BufEnter *.jl",
    ft = { "julia" },
    -- event = { "julia" },
    config = function()
      -- vim.cmd([[set nocompatible]])
      -- vim.cmd([[filetype off]])

      -- vim.cmd([[let &runtimepath.=',~/.vim/bundle/neoterm']])

      -- Enable below for python
      -- vim.g.neoterm_repl_python = { "source ./myenv/bin/activate", "ipython" }
      -- vim.g.neoterm_repl_command = { "", "" }
      -- vim.g.neoterm_default_mod = "belowright"

      vim.g.neoterm_default_mod = "belowright"
      vim.g.neoterm_size = 16
      vim.g.neoterm_autoscroll = 1
      vim.keymap.set("n", "<leader>r", ":TREPLSendLine<cr>j")
      vim.keymap.set("n", "<leader>t", "Vip:TREPLSendLine<cr>j")
      vim.keymap.set("v", "<leader>r", ":TREPLSendSelection<cr>j")
      vim.keymap.set("i", "<C-d>", "<cmd>TREPLSendSelection<cr>")
    end,
  },
}
