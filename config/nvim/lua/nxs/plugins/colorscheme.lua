return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "dawn",
      extend_background_behind_borders = false,
      highlight_groups = {
        SnacksPickerInput = { bg = "base" },
        SnacksPickerTitle = { bg = "base" },
        SnacksPickerList = { bg = "base" },
        SnacksPickerPreview = { bg = "base" },
      },
    })

    vim.o.background = "light"
    vim.cmd("colorscheme rose-pine")
  end,
}
