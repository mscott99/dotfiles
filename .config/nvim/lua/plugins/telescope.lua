local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

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
    },
    -- change some options
    opts = {
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    -- finds too many things.
    -- pickers = {
      -- find_files = {
      --   -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      --   find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      -- },
    -- },
  },
}
