vim.pack.add({
  { src = _G.nxs.gh("rose-pine/neovim"), name = "rose-pine" },
  _G.nxs.gh("nvim-lualine/lualine.nvim"),
  _G.nxs.gh("folke/which-key.nvim"),
  _G.nxs.gh("stevearc/oil.nvim"),
})

-- ==================================================================== colorscheme
vim.opt.background = vim
  .system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true })
  :wait().stdout
  :match("Dark") and "dark" or "light"

require("rose-pine").setup({
  dark_variant = "moon",
  dim_inactive_windows = true,
})
vim.cmd("colorscheme rose-pine")

-- ==================================================================== lualine
require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "filename",
        path = 3,
      },
    },
  },
})

-- ==================================================================== whickey
local wk = require("which-key")
vim.opt.timeout = true
vim.opt.timeoutlen = 300

wk.setup({
  preset = "helix",
  show_help = false,
})

wk.add({
  {
    mode = { "n", "v" },
    { "<leader><tab>", group = "tab" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "files" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>l", group = "lsp" },
    { "<leader>s", group = "search" },
    { "<leader>v", group = "nvim" },
    { "<leader>x", group = "quickfix/loclist" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
  },
})

-- ==================================================================== oil
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  skip_confirm_for_simple_edits = true,
  lsp_file_methods = {
    enabled = true,
    autosave_changes = true,
  },
  keymaps = {
    ["<C-l>"] = false,
  },
})

_G.nxs.keybind_set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")

local setup_deferred = _G.nxs.deferred_packadd({
  -- lazy loaded since we check for light/dark mode when setting colorscheme
  _G.nxs.gh("f-person/auto-dark-mode.nvim"),
  _G.nxs.gh("catgoose/nvim-colorizer.lua"),
  _G.nxs.gh("folke/trouble.nvim"),
  _G.nxs.gh("folke/todo-comments.nvim"),
})

setup_deferred(function()
  -- ==================================================================== auto-dark-mode
  require("auto-dark-mode").setup()

  -- ==================================================================== colorizer
  require("colorizer").setup({
    -- Don't auto enable by filetype
    filetypes = {},
    options = {
      parsers = {
        css = true,
        css_fn = true,
        names = {
          enabled = false,
        },
        hex = {
          enabled = true,
          rgb = true,
          rrggbb = true,
        },
        tailwind = {
          enabled = true,
          lsp = true,
        },
      },
      display = {
        mode = "virtualtext",
        virtualtext = {
          position = "after",
        },
      },
    },
  })
end)
