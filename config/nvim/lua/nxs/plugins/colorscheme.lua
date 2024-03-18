return {
  "rose-pine/neovim",
  lazy = false,
  priority = 1000,
  name = "rose-pine",
  init = function()
    vim.cmd("colorscheme rose-pine")
  end,
}
