return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "VeryLazy",
  --   enabled = true,
  --   -- opts = {
  --   --   filetypes = {
  --   --     markdown = false,
  --   --   },
  --   -- },
  -- },
  {
    'mbbill/undotree',
    cmd="UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    }
  },
}
