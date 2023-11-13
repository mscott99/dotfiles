-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    config = function ()
        vim.g.autoformat = false
    end,
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- then: setup supertab in cmp
  {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    config = function ()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<leader>j", function() ui.nav_file(1) end, {desc = "Go to first harpooned file"})
      vim.keymap.set("n", "<leader>k", function() ui.nav_file(2) end, {desc = "Go to second harpooned file"})
      vim.keymap.set("n", "<leader>h", function() ui.nav_file(3) end, {desc = "Go to third harpooned file"})
      vim.keymap.set("n", "<leader>l", function() ui.nav_file(4) end, {desc = "Go to fourth harpooned file"})
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    keys = {
      { "<c-f>", false}, -- <c-f> already used by tmux sessionizer
      { "<c-b>", function() if not require("noice.lsp").scroll(5) then return "<c-f>" end end, silent = true, expr = true, desc = "scroll forward", mode = {"i", "n", "s"} },
    }
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   enabled = false
  -- },
  { "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = "#000000",
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {"<leader>/", false},
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {"<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>"},
      {"<leader>sS", "<cmd>Telescope lsp_workspace_symbols<CR>"}
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = { "hrsh7th/cmp-emoji", "hrsh7th/cmp-omni" },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources({
  --       { name = "nvim_lsp" },
  --       { name = "luasnip" },
  --       -- { name = "buffer" },
  --       { name = "path" },
  --       {name = "emoji"},
  --       {name = "omni"}
  --     })
  --     opts.formatting = {
  --       format = function(entry, vim_item)
  --           vim_item.menu = ({
  --             omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
  --             buffer = "[Buffer]",
  --             -- formatting for other sources
  --             })[entry.source.name]
  --           return vim_item
  --         end,
  --     }
  --   -- cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "julia",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
        disable = { "markdown", "markdown_inline", "latex" }, -- let another nvim-markdown do that.
      },
    },
  },
}

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
-- return {
--   -- add gruvbox
--   {
--     "ellisonleao/gruvbox.nvim",
--     opts = {
--       transparent_mode = true,
--       -- styles = {
--       --   sidebars = "transparent",
--       --   floats = "transparent",
--       -- },
--     },
--   },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
--
--   -- change trouble config
--   {
--     "folke/trouble.nvim",
--     -- opts will be merged with the parent spec
--     opts = { use_diagnostic_signs = true },
--   },
--
--   -- disable trouble
--   { "folke/trouble.nvim", enabled = false },
--
--   -- add symbols-outline
--   {
--     "simrat39/symbols-outline.nvim",
--     cmd = "SymbolsOutline",
--     keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
--     config = true,
--   },
--
--   -- override nvim-cmp and add cmp-emoji
--
--   -- change some telescope options and a keymap to browse plugin files
--   {
--     "nvim-telescope/telescope.nvim",
--     keys = {
--       -- add a keymap to browse plugin files
--       -- stylua: ignore
--       {
--         "<leader>fp",
--         function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--         desc = "Find Plugin File",
--       },
--     },
--     -- change some options
--     opts = {
--       defaults = {
--         layout_strategy = "horizontal",
--         layout_config = { prompt_position = "top" },
--         sorting_strategy = "ascending",
--         winblend = 0,
--       },
--     },
--   },
--
--   -- add telescope-fzf-native
--   {
--     "telescope.nvim",
--     dependencies = {
--       "nvim-telescope/telescope-fzf-native.nvim",
--       build = "make",
--       config = function()
--         require("telescope").load_extension("fzf")
--       end,
--     },
--   },
--
--   -- add pyright to lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- pyright will be automatically installed with mason and loaded with lspconfig
--         pyright = {},
--       },
--     },
--   },
--   -- add more treesitter parsers
--
--   -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
--   -- would overwrite `ensure_installed` with the new value.
--   -- If you'd rather extend the default config, use the code below instead:
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       -- add tsx and treesitter
--       vim.list_extend(opts.ensure_installed, {
--         "tsx",
--         "typescript",
--       })
--     end,
--   },
--
--   -- the opts function can also be used to change the default opts:
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function(_, opts)
--       table.insert(opts.sections.lualine_x, "😄")
--     end,
--   },
--
--   -- or you can return new options to override all the defaults
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function()
--       return {
--         --[[add your custom lualine config here]]
--       }
--     end,
--   },
--
--   -- use mini.starter instead of alpha
--   { import = "lazyvim.plugins.extras.ui.mini-starter" },
--
--   -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--   { import = "lazyvim.plugins.extras.lang.json" },
--
--   -- add any tools you want to have installed below
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "shellcheck",
--         "shfmt",
--         "flake8",
--       },
--     },
--   },
--
-- }
