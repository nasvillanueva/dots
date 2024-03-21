return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = { spelling = true },
    })
    wk.register({
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["["] = { name = "+prev" },
      ["]"] = { name = "+next" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>f"] = { name = "+files" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>x"] = { name = "+quickfix/loclist" },
      ["<leader>v"] = { name = "+nvim" },
      ["<leader><tab>"] = { name = "+tab" },
    })

    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
}
