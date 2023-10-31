return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.keymap.set("n", "<leader>1", function()
        local nvim_tree = require("nvim-tree.api")
        local current_buf = vim.api.nvim_get_current_buf()
        local current_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

        if current_buf_ft == "NvimTree" then
          nvim_tree.tree.toggle();
        else
          nvim_tree.tree.focus()
        end
      end, { desc = "Explorer: Toggle or Focus" })

      vim.keymap.set("n", "<leader>4", ":NvimTreeFindFile<CR>", { desc = "Explorer: Focus File" })

      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
        },
        view = {
          width = 40,
        },
      })
    end
  }
}
