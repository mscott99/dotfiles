return {
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        opts = {
          -- lsp = {
          --   hover = {
          --     border = require("misc.style").border,
          --   },
          -- },
          buffers = {
            -- if set to true, the filetype of the otterbuffers will be set.
            -- otherwise only the autocommand of lspconfig that attaches
            -- the language server will be executed without setting the filetype
            set_filetype = true,
          },
        },
      },
    },
    opts = {
      lspFeatures = {
        languages = { "python", "julia", "bash", "lua", "html"},
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
      vim.keymap.set("n", "<leader>qp", require("quarto").quartoPreview)
    end,
  },
}
