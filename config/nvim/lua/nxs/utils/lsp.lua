return {
  supports = function(method, bufnr)
    -- Only on nvim 0.10.0
    -- local clients = vim.lsp.get_clients({ bufnr = args.buf })
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

    for _, client in ipairs(clients) do
      if client.supports_method(method) then
        return true
      end
    end

    return false
  end,
}
