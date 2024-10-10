local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        mix_format = {
          command = "mix",
          args = { "format", "$FILENAME" },
          stdin = false,
        }
      },
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix_format" },
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
