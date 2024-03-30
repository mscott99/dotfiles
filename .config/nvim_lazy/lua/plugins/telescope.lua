local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local Util = require("lazyvim.util")

-- Clone the default Telescope configuration
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
--
-- -- I want to search in hidden/dot files.
-- table.insert(vimgrep_arguments, "--hidden")
-- -- I don't want to search in the `.git` directory.
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      -- {"<leader>/", false},
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<CR>" },
      {
        "<leader>fc",
        function()
          require("telescope.builtin")["find_files"]({
            search_dirs = {
              "~/.config/skhd/",
              "~/.config/nvim/",
              "~/.config/skhd/",
              "~/.config/yabai/",
              "~/.config/export_obsidian/",
              "~/.config/alacritty/",
            }, -- still missing the files at the root of dotfiles folder
          })
          -- Util.telescope("find_files", { cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>fh",
        function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          Util.telescope("find_files", { hidden = true, no_ignore = true, default_text = line })()
        end,
        desc = "Find Hidden Files",
      },
    },
    -- change some options
    -- opts = {
    --   defaults = {
    --     vimgrep_arguments = vimgrep_arguments,
    --     layout_strategy = "horizontal",
    --     layout_config = { prompt_position = "top" },
    --     sorting_strategy = "ascending",
    --     winblend = 0,
    --   },
    -- },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
    -- finds too many things.
    -- pickers = {
    --   find_files = {
    --     -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
    --     find_command = { "rg", "--files", "--glob", "!**/.git/*" },
    --   },
    -- },
  },
}
