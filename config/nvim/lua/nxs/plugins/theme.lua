return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "night",
  --   },
  --   init = function()
  --     vim.cmd("colorscheme tokyonight")
  --   end,
  -- },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    opts = {
      variant = "dawn",
    },
    init = function()
      vim.cmd("colorscheme rose-pine")
    end
  }
}
