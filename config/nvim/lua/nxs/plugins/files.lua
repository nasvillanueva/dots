local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()

      keybind.set("n", "<leader>E", "<CMD>Oil<CR>", "File Explorer")
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

      keybind.set("n", "<leader>e", "<CMD>NvimTreeOpen<CR>", "File Explorer: Tree")

      keybind.set(
        "n",
        "<leader>fE",
        ":NvimTreeFindFile<CR>",
        "Explorer: Focus File"
      )
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    name = "lsp-file-operations",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    opts = {},
  },
}
