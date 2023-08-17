-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[filetype plugin on
      set noswapfile
      " let g:lua_snippets_path=$XDG_CONFIG_HOME""/snippets/"
      set conceallevel=2
      let g:vim_markdown_conceal = 2
      let g:vim_markdown_math = 1
]])
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/snippets/"
