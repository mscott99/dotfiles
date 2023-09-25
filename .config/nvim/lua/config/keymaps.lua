-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Some primagen shortcuts
map({ "i" }, "jk", "<Esc>")
map({ "n", "x", "v" }, "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Go to another tmux place." })
map({ "v" }, "J", "mzJ`z")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map({ "v", "n" }, "H", "^") -- Make H for alternate file

-- Move to window using the <ctrl> hjkl keys
map({ "n", "i" }, "<C-h>", "<Esc><C-w>h", { desc = "Go to left window", remap = true })
map({ "n", "i" }, "<C-j>", "<Esc><C-w>j", { desc = "Go to lower window", remap = true })
map({ "n", "i" }, "<C-k>", "<Esc><C-w>k", { desc = "Go to upper window", remap = true })
map({ "n", "i" }, "<C-l>", "<Esc><C-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set({ "x", "v" }, "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "n", "nzzzv")
vim.keymap.set({ "n", "v" }, "N", "Nzzzv")

local ui = require("harpoon.ui")
map("n", "<leader>j", function()
  ui.nav_file(1)
end, { desc = "Go to first harpooned file" })
map("n", "<leader>k", function()
  ui.nav_file(2)
end, { desc = "Go to second harpooned file" })
map("n", "<leader>h", function()
  ui.nav_file(3)
end, { desc = "Go to third harpooned file" })

map("n", "<leader>l", function()
  ui.nav_file(4)
end, { desc = "Go to fourth harpooned file" })
map("n", ";", ":") -- Get to commands faster.
