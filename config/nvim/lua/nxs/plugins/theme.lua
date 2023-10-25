return {
  {
    "LunarVim/horizon.nvim",
    lazy = false, -- used by themeable plugins, needs to be loaded right away
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "horizon"
    end
  }
}
