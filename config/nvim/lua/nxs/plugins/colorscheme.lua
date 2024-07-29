return {
 "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme neofusion")
  end,
}
