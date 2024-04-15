return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        ["*"] = { "codespell", "trim_whitespace" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      },
    },
  },
}
