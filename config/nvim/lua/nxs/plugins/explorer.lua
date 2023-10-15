return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      vim.keymap.set("n", "<leader>1", ":Oil<CR>", { desc = "Open File Explorer" })

      require("oil").setup()
    end
  }
}
