return {
  {
    "easymotion/vim-easymotion",
    event = "VeryLazy",
    keys = {
      {
        "s",
        "<Plug>(easymotion-overwin-f2)",
        mode = "n",
        desc = "EasyMotion",
      }
    },
    init = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 1
      vim.g.EasyMotion_use_migemo = 1
    end
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end
  },
  {
    "terryma/vim-multiple-cursors",
    event = "VeryLazy",
  }
}
