return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = { spelling = true },
    })
    wk.add({
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tab" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "files" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>l", group = "lsp" },
        { "<leader>s", group = "search" },
        { "<leader>v", group = "nvim" },
        { "<leader>x", group = "quickfix/loclist" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
      },
    })

    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
}
