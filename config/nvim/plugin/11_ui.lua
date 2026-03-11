MiniDeps.now(function()
  MiniDeps.add({ source = "rose-pine/neovim", name = "rose-pine" })
  require("rose-pine").setup({
    dark_variant = "moon",
    dim_inactive_windows = true,
  })

  vim.o.background = "dark"
  vim.cmd("colorscheme rose-pine")
end)

MiniDeps.now(function()
  MiniDeps.add({ source = "nvim-lualine/lualine.nvim" })

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
end)

MiniDeps.now(function()
  MiniDeps.add({ source = "folke/which-key.nvim" })

  local wk = require("which-key")
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

  vim.opt.timeout = true
  vim.opt.timeoutlen = 300
end)

MiniDeps.now(function()
  MiniDeps.add({ source = "stevearc/oil.nvim" })

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
end)

MiniDeps.later(function()
  MiniDeps.add({ source = "catgoose/nvim-colorizer.lua" })

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

MiniDeps.later(function()
  MiniDeps.add({ source = "folke/trouble.nvim" })

  local trouble = require("trouble")
  trouble.setup({
    use_diagnostic_signs = true,
    auto_close = true,
    auto_preview = false,
  })

  _G.nxs.keybind_set(
    "n",
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    "Document Diagnostics (Trouble)"
  )
  _G.nxs.keybind_set(
    "n",
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    "Workspace Diagnostics (Trouble)"
  )
  _G.nxs.keybind_set(
    "n",
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    "Location List (Trouble)"
  )
  _G.nxs.keybind_set(
    "n",
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    "Quickfix List (Trouble)"
  )
  _G.nxs.keybind_set("n", "[q", function()
    if require("trouble").is_open() then
      trouble.prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Previous trouble/quickfix item")
  _G.nxs.keybind_set("n", "]q", function()
    if require("trouble").is_open() then
      trouble.next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end, "Next trouble/quickfix item")
end)

MiniDeps.later(function()
  MiniDeps.add({ source = "folke/todo-comments.nvim" })

  _G.nxs.keybind_set("n", "]t", function()
    require("todo-comments").jump_next()
  end, "Next todo comment")
  _G.nxs.keybind_set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, "Previous todo comment")
  _G.nxs.keybind_set(
    "n",
    "<leader>xt",
    "<cmd>TodoTrouble<cr>",
    "Todo (Trouble)"
  )
  _G.nxs.keybind_set(
    "n",
    "<leader>xT",
    "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
    "Todo/Fix/Fixme (Trouble)"
  )
end)
