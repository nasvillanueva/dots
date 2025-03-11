local keybind = require("nxs.utils.keybind")

return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {},
  },
  keys = {
    keybind.lazyKey("n", "<leader>gg", function()
      require("snacks").lazygit.open()
    end, "LazyGit"),
    keybind.lazyKey("n", "<leader>gf", function()
      require("snacks").lazygit.log_file()
    end, "LazyGit: Current File Commit History"),
    keybind.lazyKey("n", "<leader>gl", function()
      require("snacks").lazygit.log()
    end, "LazyGit: Git Log"),
  },
}
