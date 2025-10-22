return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "soft",
      dim_inactive_windows = true,
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme everforest")
  end,
}
