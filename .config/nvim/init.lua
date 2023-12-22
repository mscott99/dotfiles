-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("export.export_obsidian")

vim.g.autoformat = false

vim.cmd([[filetype plugin on
      set noswapfile
      " let g:lua_snippets_path=$XDG_CONFIG_HOME""/snippets/"
      set conceallevel=2
      let g:vim_markdown_conceal = 2
      let g:vim_markdown_math = 1
]])
-- vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/luasnippets/"
