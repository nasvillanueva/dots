return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    specs = {
      require("nxs.plugins.snacks.picker"),
      require("nxs.plugins.snacks.lazygit"),
      require("nxs.plugins.snacks.indent"),
    },
  },
}
