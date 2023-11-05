return {
  {
    "akinsho/horizon.nvim",
    version = "*",
    init = function()
      local colors = require("horizon.palette-dark")

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.theme.color_column_fg })
        end,
      })

      vim.o.background = "dark"
      vim.cmd("colorscheme horizon")
    end,
  },
}
