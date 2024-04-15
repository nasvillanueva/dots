local lsp = require("nxs.utils.lsp")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  callback = function()
    if vim.fn.exists(":EslintFixAll") ~= 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if lsp.supports("textDocument/formatting", args.buf) then
      vim.lsp.buf.format({ async = true })
    end
  end,
})
