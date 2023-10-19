return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- used by themeable plugins, needs to be loaded right away
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
