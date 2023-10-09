return {
  { 
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    keys = {
      { '<leader>1', ':NvimTreeToggle<cr>', desc = 'Toggle File Explorer' }
    },
    config = function() 
       require('nvim-tree').setup({})
    end,
    init = function()
      vim.g.nvim_tree_group_empty = 1 -- somehow not working
    end,
  },
}
