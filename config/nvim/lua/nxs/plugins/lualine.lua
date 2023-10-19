return {
  {
    'hoob3rt/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_c = { { 'filename', path = 3 } },
        lualine_x = {},
      },
    }
  },
}
