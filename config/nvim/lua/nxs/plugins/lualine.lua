return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "diegoulloao/neofusion.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = require("neofusion.lualine"),
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_b = { "diagnostics" },
          lualine_c = {
            { "filename", path = 3 },
          },
          lualine_x = {
            "branch",
            "filetype",
          },
          lualine_y = {},
        },
      })
    end,
  },
}
