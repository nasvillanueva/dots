return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-ts-autotag").setup()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "po", "ipkg" },
        indent = { enable = true },
        highlight = { enable = true },
        additional_vim_regex_highlighting = false,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V",
          },
        },
      })
    end,
    init = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end,
  },
}
