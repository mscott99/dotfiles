return {
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {} -- let supertab deal with it
    end,
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnippets/" })
      require("luasnip").config.setup({ enable_autosnippets = true,
        link_children = true,

      })
      vim.cmd[[sunmap n]]
      -- improvement; load math snippets for the right file types.
      -- load_ft_func = function(bufnr)
      --   if bufnr == "markdown" then
      --     -- will load `react.lua` for this buffer
      --     return { "markdown", "tex" }
      --   else
      --     return require("luasnip.extras.filetype_functions").from_filetype_load
      --   end
      -- end
    end,
  },
  {
    "mscott99/luasnip-latex-snippets.nvim",
    enabled = false,
    -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    -- using treesitter.
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex", "nvim-treesitter" },
    -- jtreesitter is required for markdown
    ft = { "tex", "markdown" },
    opts = { use_treesitter = true },
  },
}
