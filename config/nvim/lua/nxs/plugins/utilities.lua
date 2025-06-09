local keybind = require("nxs.utils.keybind")

return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = { enable_autocmd = false },
      },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({}, {
        RGB = true,
        RRGGBB = true,
        names = false,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "snacks_picker_input",
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    init = function()
      keybind.set("n", "<leader>sr", function()
        require("spectre").open()
      end, "Replace in files (Spectre)")
    end,
  },
  {
    "bsuth/emacs-bindings.nvim",
    config = function()
      vim.g.loaded_emacs_bindings = true

      local emacs = require("emacs-bindings")

      local mode = { "i", "c" }

      keybind.set(mode, "<C-f>", "<Right>")
      -- keybind.set(mode, "<C-a>", "<Home>")
      -- keybind.set(mode, "<C-e>", "<End>")
      keybind.set(mode, "<A-b>", emacs.move_word_back)
      keybind.set(mode, "<A-f>", emacs.move_word_forward)
      keybind.set(mode, "<C-h>", emacs.delete_char_back)
      keybind.set(mode, "<C-d>", emacs.delete_char_forward)
      keybind.set(mode, "<A-backspace>", emacs.delete_word_back)
      keybind.set(mode, "<A-d>", emacs.delete_word_forward)
      keybind.set(mode, "<C-u>", emacs.delete_line_back)
      keybind.set(mode, "<C-k>", emacs.delete_line_forward)
    end,
  },
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    opts = {},
  },
}
