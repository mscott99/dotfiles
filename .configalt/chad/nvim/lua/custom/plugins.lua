local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
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
  -- {
  --   "abecodes/tabout.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
  --     act_as_tab = true, -- shift content if tab out is not possible
  --     default_tab = "", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
  --     enable_backwards = false, -- well ...
  --     completion = true, -- if the tabkey is used in a completion pum
  --     tabouts = {
  --       { open = "'", close = "'" },
  --       { open = '"', close = '"' },
  --       { open = "`", close = "`" },
  --       { open = "(", close = ")" },
  --       { open = "[", close = "]" },
  --       { open = "{", close = "}" },
  --       { open = "\\|", close = "\\|" },
  --     },
  --     ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
  --     exclude = {}, -- tabout will ignore these filetypes
  --   },
  --   dependencies = { "nvim-treesitter", "nvim-cmp", "luasnip" },
  -- },
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
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(_, opts)
      local dap = require "dap"
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end
      vim.api.nvim_set_keymap("n", "<F8>", [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "<F9>", [[:lua require"dap".continue()<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "<F10>", [[:lua require"dap".step_over()<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "<S-F10>", [[:lua require"dap".step_into()<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "<F12>", [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
      vim.api.nvim_set_keymap("n", "<F5>", [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })
    end,
  },
  -- Attempts at a python repl below
  -- {'Vigemus/iron.nvim',
  -- event="BufRead *.py"},
  -- { -- Doing the REPL for python
  --   "geg2102/nvim-python-repl",
  --   ft = "python",
  --   config = function()
  --     vim.keymap.set("n", "<leader>r","<cmd>SendPyObject<CR>")
  --     vim.keymap.set("v", "<leader>r","<cmd><C-U>SendPySelection<CR>")
  --   end
  -- },
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  { -- REPL for Julia
    "kassio/neoterm",
    ft = { "python", "julia" },
    config = function()
      vim.cmd [[set nocompatible]]
      vim.cmd [[filetype off]]

      vim.cmd [[let &runtimepath.=',~/.vim/bundle/neoterm']]

      vim.cmd [[filetype plugin on]]

      -- Enable below for python
      vim.g.neoterm_repl_python = { "source ./myenv/bin/activate", "ipython" }
      vim.g.neoterm_repl_command = { "", "" }
      vim.g.neoterm_default_mod = "belowright"

      vim.g.neoterm_default_mod = "belowright"
      vim.g.neoterm_size = 16
      vim.g.neoterm_autoscroll = 1
      vim.keymap.set("n", "<leader>r", ":TREPLSendLine<cr>j")
      vim.keymap.set("v", "<leader>r", ":TREPLSendSelection<cr>j")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      local mark = require "harpoon.mark"
      local ui = require "harpoon.ui"

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-g>", function()
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        ui.nav_file(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        ui.nav_file(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        ui.nav_file(4)
      end)
    end,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "machakann/vim-sandwich",
    event = "VeryLazy",
    config = function()
      -- local personnal_maps = require("custom.configs.sandwich_recipes")
      -- vim.g['sandwich#recipes'] = vim.tbl_extend(vim.deepcopy(vim.g['sandwich#default_recipes']), personnal_maps)
      -- print(personnal_maps)
      --
      -- Do not shadow the "s" keybind
      vim.cmd [[runtime macros/sandwich/keymap/surround.vim
        nunmap sa
        xunmap sa
        ounmap sa
        nmap <leader>sa <Plug>(sandwich-add)
        xmap <leader>sa <Plug>(sandwich-add)
        omap <leader>sa <Plug>(sandwich-add)
        nunmap sr
        xunmap sr
        nmap <leader>sr <Plug>(sandwich-replace)
        xmap <leader>sr <Plug>(sandwich-replace)
        nunmap srb
        nmap <leader>srb <Plug>(sandwich-replace-auto)
        nunmap sd
        xunmap sd
        nmap <leader>sd <Plug>(sandwich-delete)
        xmap <leader>sd <Plug>(sandwich-delete)
        nunmap sdb
        nmap <leader>sdb <Plug>(sandwich-delete-auto)
      ]]
      vim.cmd [[
        let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
        let g:sandwich#recipes += [{'buns': ['\|', '\|'], 'input':['n']}]
        let g:sandwich#recipes += [{'buns': ['\langle ', '\rangle '], 'input':['<']}]
      ]]
    end,
  },
  {
    "goolord/alpha-nvim",
    disable = false,
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
  {
    "nvim-treesitter/playground",
    lazy = false,
  },
  {
    "lervag/vimtex",
    lazy = true,
    event = "BufEnter *.tex",
  },
  {
    "windwp/nvim-autopairs",
    enabled = true,
  },
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = "BufRead " .. vim.fn.expand "~" .. "/Obsidian/**.md",
    cmd = { "ObsidianOpen", "ObsidianQuickSwitch", "ObsidianSearch" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- Optional, for completion.
      "hrsh7th/nvim-cmp",

      -- Optional, for search and quick-switch functionality.
      "nvim-telescope/telescope.nvim",

      -- Optional, an alternative to telescope for search and quick-switch functionality.
      -- "ibhagwan/fzf-lua"

      -- Optional, another alternative to telescope for search and quick-switch functionality.
      -- "junegunn/fzf",
      -- "junegunn/fzf.vim"

      -- Optional, alternative to nvim-treesitter for syntax highlighting.
      "godlygeek/tabular",
      -- "preservim/vim-markdown",
      "ixru/nvim-markdown",
    },
    opts = {
      dir = "~/Obsidian/myVault/", -- no need to call 'vim.fn.expand' here

      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = "Zettelkasten/",
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Temporal/Daily Notes/",
        -- Optional, if you want to change the date format for daily notes.
        date_format = "%Y-%m-%d",
      },

      -- Optional, completion.
      completion = {
        nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
      },

      -- -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        return title
      end,
      --
      -- Optional, set to true if you don't want Obsidian to manage frontmatter.
      disable_frontmatter = true,

      -- Optional, alternatively you can customize the frontmatter data.
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        local out = {}
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- -- Optional, for templates (see below).
      -- templates = {
      --   subdir = "templates",
      --   date_format = "%Y-%m-%d-%a",
      --   time_format = "%H:%M",
      -- },
      --
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart { "open", url } -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      -- Optional, by default commands like `:ObsidianSearch` will attempt to use
      -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
      -- first one they find. By setting this option to your preferred
      -- finder you can attempt it first. Note that if the specified finder
      -- is not installed, or if it the command does not support it, the
      -- remaining finders will be attempted in the original order.
      finder = "telescope.nvim",
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
      -- see also: 'follow_url_func' config option above.
      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true })
    end,
  },
  -- Override plugin definition options
  {
    -- "preservim/vim-markdown",
    "ixru/nvim-markdown",
    config = function()
      vim.cmd [[set conceallevel=2
      let g:vim_markdown_conceal = 2
      let g:vim_markdown_math = 1
      map <Plug> <Plug>Markdown_Fold
      nmap zc <Plug>Markdown_Fold
     " let g:vim_markdown_fenced_languages = ['julia=jl']
      ]]
    end,
    enabled = true,
    lazy = false,
    -- ft='markdown'
    -- event="BufEnter *.md"
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    enabled = true,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
      vim.g.nvimtree_side = opts.view.side
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI", enable_autosnippets = true },
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
