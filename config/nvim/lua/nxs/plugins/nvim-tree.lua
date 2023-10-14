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
      vim.g.nvim_tree_group_empty = 1

      -- Disable netrw in favor of NvimTree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('nvim-tree').setup({})
    end,
  },
}
