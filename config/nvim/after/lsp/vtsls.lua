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
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            languages = { "vue" },
            location = vim.fn.expand("$MASON")
              .. "/packages/vue-language-server/node_modules/@vue/language-server",
            configNamespace = "typescript",
          },
        },
      },
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    javascript = {
      format = { enable = false },
      referencesCodeLens = { enabled = false },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    typescript = {
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
