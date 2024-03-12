local lazyload = require("nxs.utils.lazyload")

lazyload.add(function()
  vim.cmd.packadd("nvim-surround")

  require("nvim-surround").setup({})
end)

lazyload.add(function()
  vim.cmd.packadd("Comment.nvim")

  require("Comment.nvim").setup({})
end)

lazyload.add(function()
  vim.cmd.packadd("nvim-colorizer.lua")

  require("colorizer").setup({
    RGB = true,
    RRGGBB = true,
    names = false,
  })
end)

lazyload.add(function()
  vim.cmd.packadd("indent-blankline.nvim")

  require("ibl").setup({
    indent = { char = "┊" },
    scope = {
      enabled = false,
    },
  })
end)
