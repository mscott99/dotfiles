local M = {}

local cmp = require "cmp"
M.cmp = {
  disabled = {
    ["<CR>"] = "",
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    -- ["<CR>"] = "",
    ["<Tab>"] = cmp.mapping(function(fallback)
      --modification: prioritize snippet jumping
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    -- { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

M.treesitter = {
  ensure_installed = {
    "query",
    "vim",
    "lua",
    "python",
    "markdown_inline",
    "markdown",
    "latex"
  },
  indent = {
    enable = true,
    disable = {
      "python"
    },
  },
  highlight = {
      enable = true,
      disable = {"markdown", "markdown_inline"}, -- let another nvim-markdown do that.
  },
  -- EXTENSION_WIKI_LINK=true
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    "python-lsp-server",
    "julia-lsp"
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
