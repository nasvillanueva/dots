local keybind = require("nxs.utils.keybind")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  renderer = {
    group_empty = false,
  },
  view = {
    width = 30,
  },
  on_attach = function(bufnr)
    local nvim_tree = require("nvim-tree.api")

    nvim_tree.config.mappings.default_on_attach(bufnr)

    keybind.set("n", "<leader>1", function()
      local nvim_tree = require("nvim-tree.api")
      local current_buf = vim.api.nvim_get_current_buf()
      local current_buf_ft =
        vim.api.nvim_get_option_value("filetype", { buf = current_buf })

      if current_buf_ft == "NvimTree" then
        nvim_tree.tree.toggle()
      else
        nvim_tree.tree.focus()
      end
    end, "Explorer: Toggle")

    keybind.set(
      "n",
      "<leader>4",
      ":NvimTreeFindFile<CR>",
      "Explorer: Focus File"
    )
  end,
})
