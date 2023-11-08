return {
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_preview = false,
    },
    init = function()
      vim.keymap.set(
        "n",
        "<leader>t",
        ":TroubleToggle<CR>",
        { desc = "Toggle Trouble" }
      )
    end,
  },
}
