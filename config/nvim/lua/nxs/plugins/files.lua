local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
      lsp_file_methods = {
        enabled = true,
        autosave_changes = true,
      },
    },
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      keybind.set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")
    end,
  },
}
