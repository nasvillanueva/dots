-- Requires running :TSUpdate on every update

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  ignore_install = { "po" },
  indent = { enable = true },
  highlight = { enable = true },
  autotag = { enable = true },
  additional_vim_regex_highlighting = false,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
