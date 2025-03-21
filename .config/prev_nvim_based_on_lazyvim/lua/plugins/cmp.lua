-- Figure out how to change the sources for different files.
-- vim.cmd([[autocmd FileType markdown require('cmp').setup.buffer { sources = { { name = 'luasnip' }, } }]])

-- cmp = require("cmp")
-- local markdown_sources = cmp.config.sources({
--   { name = "nvim_lsp" },
--   { name = "luasnip" },
--   -- { name = "buffer" }, too anoying for makdown.
--   { name = "path" },
--   { name = "emoji" },
--   { name = "omni" },
--   { name = "copilot" },
-- })
--
-- local standard_sources = cmp.config.sources({
--   { name = "nvim_lsp" },
--   { name = "luasnip" },
--   { name = "buffer" },
--   { name = "path" },
--   { name = "emoji" },
--   { name = "omni" },
--   { name = "copilot" },
-- })
--
-- vim.api.nvim_create_autocmd("BufReadPre", {
--   callback = function(t)
--     cmp.setup.buffer({
--       sources = standard_sources,
--     })
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = "*.md",
--   callback = function(t)
--     cmp.setup.buffer({
--       sources = markdown_sources,
--     })
--   end,
-- })

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      -- Supertab
      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      local luasnip = require("luasnip")
      -- local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.confirm(),
          ["<C-Q>"] = cmp.mapping.abort(),
          -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              -- elseif cmp.visible() then
              -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
              -- cmp.select_next_item()
              -- cmp.confirm({ select = true })
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- this way you will only jump inside the snippet region
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "copilot" },
            { name = "emoji" },
            { name = "otter" },
          }
          --       , {
          --   { name = "buffer" },
          -- }
        ),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    --   ---@param opts cmp.ConfigSchema
    --   opts = function(_, opts)
    --     local cmp = require("cmp")
    --     opts.sources = cmp.config.sources({
    --       { name = "nvim_lsp" },
    --       { name = "luasnip" },
    --       -- { name = "buffer" }, too anoying for makdown.
    --       { name = "path" },
    --       { name = "emoji" },
    --       { name = "omni" },
    --       { name = "copilot"},
    --     })
    --     opts.formatting = {
    --       format = function(entry, vim_item)
    --         vim_item.menu = ({
    --           omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
    --           buffer = "[Buffer]",
    --           -- formatting for other sources
    --         })[entry.source.name]
    --         return vim_item
    --       end,
    --     }
    --     cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    --
    --     -- Supertab
    --     local has_words_before = function()
    --       unpack = unpack or table.unpack
    --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --     end
    --
    --     local luasnip = require("luasnip")
    --     -- local cmp = require("cmp")
    --
    --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --       ["<Tab>"] = cmp.mapping(function(fallback)
    --         if luasnip.expand_or_jumpable() then
    --           luasnip.expand_or_jump()
    --           -- elseif cmp.visible() then
    --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
    --           -- cmp.select_next_item()
    --           -- cmp.confirm({ select = true })
    --           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --           -- this way you will only jump inside the snippet region
    --         else
    --           fallback()
    --         end
    --       end, { "i", "s" }),
    --       ["<S-Tab>"] = cmp.mapping(function(fallback)
    --         if luasnip.jumpable(-1) then
    --           luasnip.jump(-1)
    --         else
    --           fallback()
    --         end
    --       end, { "i", "s" }),
    --     })
    --   end,
  },
}
