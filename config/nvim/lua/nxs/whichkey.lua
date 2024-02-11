local lazyload = require("nxs.utils.lazyload")

lazyload.add(function()
  vim.cmd.packadd("which-key.nvim")

  require("which-key").setup({})

  vim.opt.timeout = true
  vim.opt.timeoutlen = 300
end)

