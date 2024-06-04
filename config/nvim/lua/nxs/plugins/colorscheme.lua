return {
 "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  name = "rose-pine",
  init = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme neofusion")
  end,
}
