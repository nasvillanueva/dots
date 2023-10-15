return {
  {
    "lunarvim/synthwave84.nvim",
    lazy = false, -- used by themeable plugins, needs to be loaded right away
    priority = 100,
    init = function()
      vim.cmd("colorscheme synthwave84")
      -- Prefer terminal bg color
      vim.cmd("hi Normal ctermbg=none guibg=none")
    end
  }
}
