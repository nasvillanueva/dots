vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  callback = function()
    if vim.fn.exists(":EslintFixAll") ~= 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.ex", "*.exs", "*.heex" },
--   callback = function(args)
--     local filename = vim.api.nvim_buf_get_name(args.buf)
--
--     vim.system({ "mix", "format", filename })
--     -- TODO: Reload the file automatically?
--     -- Also, using :wait() shows prompt about saving an already-modified-file
--   end,
-- })
