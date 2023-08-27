---@type MappingsTable
local M = {}

M.disabled = {
  n = { ["<leader>pt"] = "", ["<tab>"] = "", ["<S-tab>"] = "", ["<C-n>"] = "" },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["L"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["H"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.general = {
  n = {
    ["<leader>mp"] = { "<cmd>MarkdownPreviewToggle<CR>", "[m]arkdown [p]review" },
    -- [";"] = { ":", "Command", opts = { nowait = true } },
    -- ["m"] = { ";", "Next inline search", opts = { nowait = true } },
    ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Go to another tmux place.", opts = { nowait = true } },
    ["J"] = { "mzJ`z", opts = { nowait = true } },

    ["<C-d>"] = { "<C-d>zz", "Down half page", opts = { nowait = true } },
    ["<C-u>"] = { "<C-u>zz", "Up half page", opts = { nowait = true } },

    -- Plugins
    ["<leader>u"] = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
    ["<leader>o"] = { "<cmd>ObsidianQuickSwitch<CR>", "Open Obsidian Note" },
    ["<leader>gs"] = { "<cmd>Git<CR>", "Git Status" },

    -- next in search; and stay centered
    ["n"] = { "nzzzv", opts = { nowait = true } },
    ["N"] = { "Nzzzv", opts = { nowait = true } },

    -- next greatest remap ever : asbjornHaland
    ["<leader>y"] = { [[+y]], "Yank clipboard", opts = { nowait = true } },
    ["<leader>Y"] = { [[+Y]], opts = { nowait = true } },

    ["<leader>d"] = { [["_d]], "Delete without yanking", opts = { nowait = true } },

    ["Q"] = { "<nop>", opts = { nowait = true } },
    ["<leader>f"] = { vim.lsp.buf.format, "Format", opts = { nowait = true } },

    ["<leader>ss"] = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "Replace around all words",
      opts = { nowait = true },
    },
    ["<leader><C-x>"] = { "<cmd>!chmod +x %<CR>", opts = { silent = true } },
    ["<A-k>"] = { "<cmd>cprev<CR>zz" },
    ["<A-j>"] = { "<cmd>cnext<CR>zz" },
  },
  i = {
    ["jk"] = { "<ESC>", "Escape insert mode", opts = { nowait = true } },
  },
  v = {
    ["<leader>d"] = { [["_d]], opts = { nowait = true } },
    ["J"] = { ":m '>+1<CR>gv=gv", opts = { nowait = true } },
    ["K"] = { ":m '<-2<CR>gv=gv", opts = { nowait = true } },
  },
  x = {
    -- greatest remap ever
    ["<leader>p"] = { [["_dP]], opts = { nowait = true } },
  },
}

M.nvimtree = {
  -- plugin = true,
  -- disabled = {
  --   n = {
  --   ["<C-n>"] =  ""
  --   }
  -- },
  n = {
    -- -- toggle
    -- ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}
-- moe k!

return M
