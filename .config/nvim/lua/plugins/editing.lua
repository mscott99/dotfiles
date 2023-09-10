return {
  {
    "lervag/vimtex",
    enabled = true,
    keys = {
      { "<leader>vc", "<cmd>VimtexCompile<CR>", desc = "Compile tex document" },
    },
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "machakann/vim-sandwich",
    event = "VeryLazy",
    config = function()
      -- local personnal_maps = require("custom.configs.sandwich_recipes")
      -- vim.g['sandwich#recipes'] = vim.tbl_extend(vim.deepcopy(vim.g['sandwich#default_recipes']), personnal_maps)
      -- print(personnal_maps)
      --
      -- Do not shadow the "s" keybind
      vim.cmd([[runtime macros/sandwich/keymap/surround.vim
        nunmap sa
        xunmap sa
        ounmap sa
        nmap gsa <Plug>(sandwich-add)
        xmap gsa <Plug>(sandwich-add)
        omap gsa <Plug>(sandwich-add)
        nunmap sr
        xunmap sr
        nmap gsr <Plug>(sandwich-replace)
        xmap gsr <Plug>(sandwich-replace)
        nunmap srb
        nmap gsrb <Plug>(sandwich-replace-auto)
        nunmap sd
        xunmap sd
        nmap gsd <Plug>(sandwich-delete)
        xmap gsd <Plug>(sandwich-delete)
        nunmap sdb
        nmap gsdb <Plug>(sandwich-delete-auto)
      ]])
      vim.cmd([[
        let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
        let g:sandwich#recipes += [{'buns': ['\|', '\|'], 'input':['n']}]
        let g:sandwich#recipes += [{'buns': ['\left\|', '\right\|'], 'input':['N']}]
        let g:sandwich#recipes += [{'buns': ["[[", "]\]"], 'input':['w']}]
        let g:sandwich#recipes += [{'buns': ['\langle ', '\rangle '], 'input':['<']}]
      ]])
    end,
  },
}
