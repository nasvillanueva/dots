return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { "windwp/nvim-ts-autotag", },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        indent = { enable = true },
        highlight = { enable = true },
        autotag = { enable = true },
      })
    end
  }
}
