return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      variant = "moon",
      extend_background_behind_borders = false,
      highlight_groups = {
        SnacksPickerInput = { bg = "base" },
        SnacksPickerTitle = { bg = "base" },
        SnacksPickerList = { bg = "base" },
        SnacksPickerPreview = { bg = "base" },
        SnacksPickerIdx = { link = "SnacksPickerCol" },
        SnacksPickerRow = { link = "SnacksPickerCol" },
      },
    })

    vim.o.background = "dark"
    vim.cmd("colorscheme rose-pine")
  end,
}
