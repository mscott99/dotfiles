-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
--


-- The code below starts nvim tree when starting nvim, but throws an error.

-- local autocmd = vim.api.nvim_create_autocmd
--
-- local function open_nvim_tree(data)
--
--     -- buffer is a directory
--     local directory = vim.fn.isdirectory(data.file) == 1
--
--     -- buffer is a [No Name]
--     local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
--     if not directory and not no_name then
--         return
--     end
--
--     if directory then
--         -- change to the directory
--         vim.cmd.cd(data.file)
--     end
--
--     -- open the tree
--     require("nvim-tree.api").tree.open()
-- end

-- autocmd({ "VimEnter" }, { callback = open_nvim_tree })

