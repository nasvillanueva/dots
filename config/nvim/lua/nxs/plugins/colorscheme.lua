return {
  "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neofusion").setup()

    vim.o.background = "dark"
    vim.cmd("colorscheme neofusion")
  end,
}
