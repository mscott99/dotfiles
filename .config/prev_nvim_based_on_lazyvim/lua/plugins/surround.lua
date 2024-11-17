return {
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    enabled = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        -- main content is found in scripts/surround_functions.lua and ftplugin files.
        surrounds = {
        }
      })
    end,
  },
  {
    "machakann/vim-sandwich",
    enabled = true,
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
        let g:sandwich#recipes += [{'buns': ['\left(', '\right)'], 'input':['P']}]
        let g:sandwich#recipes += [{'buns': ['\left[', '\right]'], 'input':['B']}]
        let g:sandwich#recipes += [{'buns': ['\|', '\|'], 'input':['n']}]
        let g:sandwich#recipes += [{'buns': ['\{', '\}'], 'input':['s']}]
        let g:sandwich#recipes += [{'buns': ['\left\{', '\right\}'], 'input':['S']}]
        let g:sandwich#recipes += [{'buns': ['\left\|', '\right\|'], 'input':['N']}]
        let g:sandwich#recipes += [{'buns': ["[[", "]\]"], 'input':['w']}]
        let g:sandwich#recipes += [{'buns': ['\langle ', '\rangle '], 'input':['a']}]
        let g:sandwich#recipes += [{'buns': ['\left\langle ', '\right\rangle'], 'input':['A']}]
        let g:sandwich#recipes += [{'buns': ['\left| ', '\right|'], 'input':['L']}]
      ]])
    end,
  },
}
