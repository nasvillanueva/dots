return {
  on_attach = function(client)
    if vim.bo.filetype == "vue" then
      client.server_capabilities.semanticTokensProvider.full = false
    else
      client.server_capabilities.semanticTokensProvider.full = true
    end
  end,
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        languages = { "vue" },
        location = vim.fn.expand("$MASON")
          .. "/packages/vue-language-server/node_modules/@vue/language-server",
        configNamespace = "typescript",
      },
    },
  },
  settings = {
    javascript = {
      format = { enable = false },
      referencesCodeLens = { enabled = false },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    typescript = {
      tsserver = { maxTsServerMemory = 8192 },
      format = { enable = false },
      referencesCodeLens = { enabled = false },
      implementationsCodeLens = { enabled = false },
      preferences = {
        includePackageJsonAutoImports = "off",
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },
}
