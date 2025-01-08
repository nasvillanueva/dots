local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      keybind.set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
        },
        view = {
          float = {
            enable = true,
          },
        },
      })

      keybind.set(
        "n",
        "<leader>E",
        "<CMD>NvimTreeOpen<CR>",
        "File Explorer: Tree"
      )

      keybind.set(
        "n",
        "<leader>fE",
        ":NvimTreeFindFile<CR>",
        "Explorer: Focus File"
      )
    end,
  },
}
