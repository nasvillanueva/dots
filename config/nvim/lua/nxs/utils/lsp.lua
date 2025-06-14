return {
  supports = function(method, lsp_attach_args)
    local client = vim.lsp.get_client_by_id(lsp_attach_args.data.client_id)

    return client.supports_method(method, lsp_attach_args.buf)
  end,
}
