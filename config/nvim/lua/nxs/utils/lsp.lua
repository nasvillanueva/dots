return {
  supports = function(method, client_id)
    local client = vim.lsp.get_client_by_id(client_id)

    return client.supports_method(method)
  end,
}
