return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "hard",
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme everforest")
  end,
}
