-- require("nvim-treesitter.configs").setup({
vim.g.rainbow_delimiters = {}
-- })
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
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          latex = "rainbow-blocks"
        },
        priority = {
          [""] = 110,
          lua = 210,
          latex = 2000
        },
        highlight = {
          "RainbowDelimiterYellow",
          "RainbowDelimiterOrange",
          "RainbowDelimiterBlue",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
          "RainbowDelimiterRed",
        },
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
