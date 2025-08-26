return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      indent = {
        animate = {
          enabled = false,
        },
      },
    })
  end,
}
