return {
  settings = {
    Lua = {
      diagnostics = {
        -- Prevents getting Undefined global `vim`
        globals = { "vim", "Snacks", "MiniDeps" },
      },
      workspace = {
        -- Help lua_ls be aware of neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}
