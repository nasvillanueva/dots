return {
  supports = function(method, bufnr)
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    for _, client in ipairs(clients) do
      if client.supports_method(method) then
        return true
      end
    end

    return false
  end,
}
