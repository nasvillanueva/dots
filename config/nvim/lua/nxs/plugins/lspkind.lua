return {
  {
    "onsails/lspkind-nvim",
    config = function()
      local lsp_kind = require("lspkind")
      lsp_kind.init({
        symbol_map = {
          Copilot = "",
        },
      })
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    end,
  },
}
