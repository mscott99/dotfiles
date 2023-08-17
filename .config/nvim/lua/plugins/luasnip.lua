return {
  -- {
  --   "L3MON4D3/LuaSnip",
  --   opts = { history = true, updateevents = "TextChanged,TextChangedI", enable_autosnippets = true },
  -- },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {} -- let supertab deal with it
    end,
  },
  {
    "mscott99/luasnip-latex-snippets.nvim",
    -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    -- using treesitter.
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex", "nvim-treesitter" },
    -- jtreesitter is required for markdown
    ft = { "tex", "markdown" },
    opts = { use_treesitter = true },
  },
}
