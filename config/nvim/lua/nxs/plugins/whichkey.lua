return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup({
      plugins = { spelling = true },
    })
    wk.register({
      mode = { "n", "v" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>f"] = { name = "+files" },
      --["<leader>e"] = { name = "+explorer" },
    })

    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
}
