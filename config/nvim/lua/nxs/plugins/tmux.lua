local keybind = require("nxs.utils.keybind")

return {
  "alexghergh/nvim-tmux-navigation",
  opts = { disable_when_zoomed = true },
  init = function()
    keybind.set(
      "n",
      "<C-h>",
      "<CMD>NvimTmuxNavigateLeft<CR>",
      "Nvim Tmux: Left"
    )
    keybind.set(
      "n",
      "<C-j>",
      "<CMD>NvimTmuxNavigateDown<CR>",
      "Nvim Tmux: Down"
    )
    keybind.set("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>", "Nvim Tmux: Up")
    keybind.set(
      "n",
      "<C-l>",
      "<CMD>NvimTmuxNavigateRight<CR>",
      "Nvim Tmux: Right"
    )
  end,
}
