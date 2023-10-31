return {
  {
    "nvim-tree/nvim-tree.lua",
    main = "nvim-tree",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>1",
        function()
          local nvim_tree = require("nvim-tree.api")
          local current_buf = vim.api.nvim_get_current_buf()
          local current_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

          if current_buf_ft == "NvimTree" then
            nvim_tree.tree.toggle();
          else
            nvim_tree.tree.focus()
          end
        end,
        mode = "n",
        desc = "Explorer: Toggle or Focus",
      },
      {
        "<leader>4",
        ":NvimTreeFindFile<CR>",
        mode = "n",
        desc = "Explorer: Focus File",
      }
    },
    opts = {
      renderer = {
        group_empty = true,
      },
      view = {
        width = 40,
      },
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end
  }
}
