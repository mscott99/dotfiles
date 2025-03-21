return {
  {
    "f3fora/nvim-texlabconfig",
    requires = { "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      -- need to remove the -g to get the viewer to show up. Otherwise open manually
      local executable = "/Applications/Skim.app/Contents/SharedSupport/displayline"
      local args = { "-g", "%l", "%p", "%f" }
      -- local args = {"%l", "%p", "%f" }

      lspconfig.texlab.setup({
        settings = {
          texlab = {
            -- auxDirectory = ".",
            -- bibtexFormatter = "texlab",
            build = {
              onSave = true,
              -- forwardSearchAfter = false,
              forwardSearchAfter = true,
              -- args = { "-pdf", "-pvc", "-interaction=nonstopmode", "-synctex=1", "%f" },
              -- args = { "-pdf", "-interaction=nonstopmode", "-synctex=0", "%f" },
            },
            forwardSearch = {
              -- add the line
              executable = executable,
              args = args,
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false,
            },
            chktex = {
              onEdit = false,
              onOpenAndSave = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
          },
        },
      })
    end,
    ft = { "tex", "bib" }, -- Lazy-load on filetype
    -- build = "go build",
    build = "go build -o ~/.local/bin/", -- if e.g. ~/.bin/ is in $PATH
  },
  -- {
  --   "KeitaNakamura/tex-conceal.vim",
  --   enabled = false,
  --   config = function()
  --     vim.cmd([[
  --     let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
  --     let g:tex_subscripts= "[0-9abcdefgijoqruvwxyzABCDEFGHIJKLMNOQRSTUVWXYZ,+-/().]"
  --     let g:tex_conceal="abdgm"
  --     set conceallevel=2
  --     let g:tex_conceal_frac=1
  --     ]])
  --   end,
  -- },
  {
    "lervag/vimtex", -- vimtex provides the conceal and checks in math for tex snippets.
    enabled = true,
    event = "VeryLazy",
    -- event = "BufEnter *.tex *.md",
    -- tag= "v1.6",
    keys = {
      { "<leader>vc", "<cmd>VimtexCompile<CR>", desc = "Compile tex document" },
      { "<leader>vt", "<cmd>VimtexTocOpen<CR>", desc = "Latex Table of Contents" },
    },
    config = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 0 -- do not change focus
      vim.cmd([[
  nnoremap <leader>vv :call vimtex#fzf#run()<cr>
  syntax enable
  ]])

      vim.cmd([[let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : '',
        \ 'out_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-shell-escape',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
]])
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        tex = { "latexindent" },
        bib = { "latexindent" },
      },
    },
  },
}
