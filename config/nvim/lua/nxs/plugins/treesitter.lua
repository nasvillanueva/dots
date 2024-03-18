return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        ignore_install = { "po" },
        indent = { enable = true },
        highlight = { enable = true },
        autotag = { enable = true },
        additional_vim_regex_highlighting = false,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
      })
    end,
    init = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end,
  },
}
