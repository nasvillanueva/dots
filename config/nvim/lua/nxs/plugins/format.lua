local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix" },
        ["*"] = { "codespell", "trim_whitespace" },
      },
    },
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

      keybind.set("", "<leader>=", function()
        require("conform").format(
          { async = true, lsp_fallback = true },
          function()
            vim.cmd("w!")
          end
        )
      end, "Code: Format Buffer")
    end,
  },
}
