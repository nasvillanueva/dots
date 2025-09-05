local keybind = require("nxs.utils.keybind")

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix" },
        ["*"] = { "trim_whitespace" },
        -- disable formatter to let autocmd eslint run instead
        javascript = {},
        javascriptreact = {},
        typescript = {},
        typescriptreact = {},
        vue = {},
        svelte = {},
        css = { "stylelint" },
        json = { "fixjson" },
      },
      format_on_save = true,
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
