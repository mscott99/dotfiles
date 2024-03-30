return {
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function(_, opts)
      require("leap").add_default_mappings(true) -- will overwrite the s key.
      -- vim.keymap.set({'n'}, "gs", function()
      --   require("leap").leap {
      --     target_windows = vim.tbl_filter(function(win)
      --       return vim.api.nvim_win_get_config(win).focusable
      --     end, vim.api.nvim_tabpage_list_wins(0)),
      --   }
      -- end, { noremap = true, silent = true })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      -- Give the main key to leap
      -- {
      --   "s",
      --   mode = { "n", "x", "o" },
      --   function()
      --     require("flash").jump {
      --       -- Only search the beginning of words
      --       -- search = {
      --       --   mode = function(str)
      --       --     return "\\<" .. str
      --       --   end,
      --       -- },
      --     }
      --   end,
      --   desc = "Flash",
      -- },
      {
        "<leader>S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
