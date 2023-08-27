vim.cmd([[filetype plugin on
      set noswapfile
      let g:lua_snippets_path=$XDG_CONFIG_HOME""/snippets/"
]])


vim.g.lua_snippets_path = vim.fn.stdpath("config").."/snippets/"
vim.cmd[[set mouse=]]
vim.cmd [[
set rnu
set nu
set path=.,~/.config/nvim/
" Indents word-wrapped lines as much as the 'parent' line
set breakindent
" Ensures word-wrap does not split words
]]

vim.o.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 9

vim.opt.updatetime = 100

vim.filetype.add({
  pattern = {
    ["requirements*"] = "config",
  },
})

vim.opt.cursorline = true
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "gruvbox",
  theme_toggle = { "gruvbox", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  transparency = true,
}
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

-- vim.cmd([[filetype plugin on]])
-- Enable the below to get netrw working
--[[
M.lazy_nvim = {
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "editorconfig",
      },
    },
  }
}

local mygroup = vim.api.nvim_create_augroup("loading_netrwPlugin",
                                            {clear = true})
vim.api.nvim_create_autocmd({"VimEnter"}, {
    pattern = {"*"},
    callback = function()
        -- Getting the file name that you pass when you launch nvim,
        local current_file = vim.fn.expand("%")
        -- if we have already file_name, then, we edit it
        if current_file ~= "" then
            vim.cmd(":silent! edit " .. current_file)
        else
            -- We will check if the window (buffer) is the lazy nvim, as it conflict if the buffer (popup menu) is lazy
            local lazy_popup_buf_exists = false
            -- We will get list of all current opened buffers
            local buf_list = vim.api.nvim_list_bufs()
            for _, buf in ipairs(buf_list) do
                -- We will obtain from the table only the filetype
                local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
                if buf_ft == "lazy" then
                    lazy_popup_buf_exists = true
                end
            end -- Check if vim-floaterm is loaded
            local has_floaterm, _ = pcall(require, 'floaterm')
            if not lazy_popup_buf_exists and not has_floaterm then
                -- Then we can safely loading netrwPlugin at startup
                vim.cmd(":silent! Explore")
            end
        end
    end,
    group = mygroup
})
]]--
-- Enable also the below for netrw
-- vim.cmd([[set nocp]])
-- vim.cmd([[filetype plugin on]])
return M
