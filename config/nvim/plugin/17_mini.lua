local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("nvim-mini/mini.nvim"),
})

setup_deferred(function()
  require("mini.surround").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.ai").setup()
  require("mini.move").setup()
end)
