return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    opts = {
      filetypes = {
        markdown = false,
      },
    },
  },
  {
    'mbbill/undotree',
    cmd="UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    }
  },
}
