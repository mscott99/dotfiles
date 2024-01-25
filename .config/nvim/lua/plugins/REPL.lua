local start_repl = function()
  -- start based on filetype
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd([[TermExec cmd='source ./venv/bin/activate; python -m IPython --no-autoindent --matplotlib']])
  elseif filetype == "julia" then
    vim.cmd([[TermExec cmd='julia --project']])
  else
    vim.cmd([[TermExec cmd='echo "No REPL for this filetype"']])
  end
end

local trim_spaces = false
vim.keymap.set({ "n", "v" }, "<leader>R", start_repl, { desc = "start repl" })
vim.keymap.set("n", "<leader>r", function()
  require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
  vim.cmd("normal! j")
end)
vim.keymap.set({ "n", "i" }, "®", function()
  require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
  vim.cmd("normal! j")
end)

vim.keymap.set("v", "<leader>r", function()
  local tog = require("toggleterm")
  if vim.api.nvim_get_mode().mode == "v" then
    tog.send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
  elseif vim.api.nvim_get_mode().mode == "V" then
    tog.send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
  end
  vim.cmd("normal! `>") -- move to end of visual selection
end)

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },
}
