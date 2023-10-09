return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      local format_on_save_augroup = vim.api.nvim_create_augroup('null-ls-format-on-save', {})

      local function on_attach(client, bufnr) 
        if client.supports.method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({
            group = format_on_save_augroup,
            buffer = bufnr,
          })

          vim.api.nvim_create_autocmd('BufWritePre', {
            group = format_on_save_augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end
          })
        end
      end

      null_ls.setup({
        on_attach = on_attach,
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.mix,
        }
      })
    end,
  }
}
