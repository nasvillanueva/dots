local keybind = require("nxs.utils.keybind")

return {
  {
    "JellyApple102/flote.nvim",
    event = "VeryLazy",
    opts = {
      notes_dir = os.getenv("HOME") .. "/dev/notes",
    },
    init = function()
      keybind.set("n", "<leader>n", "<CMD>Flote<CR>", "Project Notes")
      keybind.set("n", "<leader>N", "<CMD>Flote global<CR>", "Global Notes")
    end,
  },
}
