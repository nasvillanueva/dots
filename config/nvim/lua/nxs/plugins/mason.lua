return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = {
    { "<leader>cm", "<cmd>Mason<CR>", desc = "Mason" }
  },
  config = function()
    require("mason").setup()
    -- TODO: Install most used tools
  end,
}
