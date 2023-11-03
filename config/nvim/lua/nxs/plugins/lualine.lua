return {
  {
    "hoob3rt/lualine.nvim",
    opts = {
      options = {
        theme = "horizon",
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_b = { "diagnostics" },
        lualine_c = {
          { "filename", path = 3 },
        },
        lualine_x = { "branch", "fileformat", "filetype" },
      },
    },
  },
}
