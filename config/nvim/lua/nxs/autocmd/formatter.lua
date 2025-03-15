vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  callback = function()
    if vim.fn.exists(":EslintFixAll") ~= 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ex", "*.exs", "*.heex" },
  callback = function(args)
    local filename = vim.api.nvim_buf_get_name(args.buf)

    vim.system({ "mix", "format", filename }, {}, function(obj)
      if obj.signal == 0 then
        vim.cmd("edit!")
      else
        vim.print(obj.stderr)
      end
    end)
  end,
})
