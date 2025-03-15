return {
  "diegoulloao/neofusion.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("neofusion").setup({
      overrides = {
        NonText = { link = "NeofusionGray" }
      }
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme neofusion")
  end,
}
