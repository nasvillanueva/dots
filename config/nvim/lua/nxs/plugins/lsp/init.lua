local keybind = require("nxs.utils.keybind")

-- TODO: Move this to separate server files
local NXS_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {
    filetypes = { "vue", "html", "css", "scss" },
  },
  elixirls = {
    cmd = {
      os.getenv("HOME")
        .. "/.local/share/nvim/mason/packages/elixir-ls/language_server.sh",
    },
  },
  eslint = {
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
  tsserver = {
    on_attach = function()
      keybind.set("", "<leader>co", ":OrganizeImports<CR>")
    end,
    commands = {
      OrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          })
        end,
        description = "Organize Imports",
      },
    },
  },
  volar = {
    filetypes = { "vue", "typescript" },
    settings = {
      scss = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
  jsonls = { filetypes = { "json", "jsonc" } },
  stylelint_lsp = {
    settings = {
      stylelintplus = {
        autoFixOnFormat = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          -- Prevents getting Undefined global `vim`
          globals = { "vim" },
        },
        workspace = {
          -- Help lua_ls be aware of neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    cmd = {
      "LspInfo",
      "LspInstall",
      "LspUninstall",
    },
    config = function()
      local server_names = {}
      for server_name, _ in pairs(NXS_LSP_CONFIG) do
        table.insert(server_names, server_name)
      end

      require("mason-lspconfig").setup({
        ensure_installed = server_names,
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local get_mason_servers = require("mason-lspconfig").get_installed_servers

      for _, server_name in ipairs(get_mason_servers()) do
        local nxs_lsp_config = NXS_LSP_CONFIG[server_name] or {}

        lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
          capabilities = lsp_capabilities,
        }, nxs_lsp_config))
      end

      -- Volar Takeover mode
      -- https://vuejs.org/guide/typescript/overview.html#volar-takeover-mode
      local volar_client = nil
      local tsserver_client = nil
      local function volar_takeover(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.name == "tsserver" then
          if volar_client then
            client:stop()
          else
            tsserver_client = client
          end
        elseif client.name == "volar" then
          volar_client = client

          if tsserver_client then
            tsserver_client:stop()
          end
        end
      end

      local function setup_keybindings(args)
        local has_capability = function(capability)
          -- Only on nvim 0.10.0
          -- local clients = vim.lsp.get_clients({ bufnr = args.buf })
          local clients = vim.lsp.get_active_clients({ bufnr = args.buf })
          local method = "textDocument/" .. capability

          for _, client in ipairs(clients) do
            if client.supports_method(method) then
              return true
            end
          end

          return false
        end

        keybind.set("n", "<leader>cli", "<cmd>LspInfo<CR>", "LSP: Info")
        keybind.set("n", "<leader>clr", "<cmd>LspRestart<CR>", "LSP: Restart")

        keybind.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          "LSP: Goto declaration",
          { buffer = args.buf }
        )
        keybind.set("n", "gI", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, "LSP: Goto Implementation")
        keybind.set("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, "LSP: Goto Type Definition")

        keybind.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          "LSP: Hover",
          { buffer = args.buf }
        )

        if has_capability("definition") then
          keybind.set("n", "gd", function()
            require("telescope.builtin").lsp_defintions({ reuse_win = true })
          end, "LSP: Goto definition", { buffer = args.buf })
        end

        if has_capability("References") then
          keybind.set(
            "n",
            "gr",
            "<cmd>Telescope lsp_references<CR>",
            "LSP: Find Usages",
            { buffer = args.buf }
          )
        end

        if has_capability("signatureHelp") then
          keybind.set(
            "n",
            "gK",
            vim.lsp.buf.signature_help,
            "LSP: Signature Help",
            { buffer = args.buf }
          )
          keybind.set(
            "i",
            "<C-k>",
            vim.lsp.buf.signature_help,
            "LSP: Signature Help",
            { buffer = args.buf }
          )
        end

        if has_capability("codeAction") then
          keybind.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            "LSP: Code Actions",
            { buffer = args.buf }
          )

          keybind.set("n", "<leader>cA", function()
            vim.lsp.buf.code_action({
              context = { only = { "source" }, diagnostics = {} },
            })
          end, "LSP: Source Action", { buffer = args.buf })
        end

        if has_capability("rename") then
          keybind.set("n", "<leader>cr", vim.lsp.buf.rename, "LSP: Rename", { buffer = args.buf })
        end

        if has_capability("codeLens") then
          keybind.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "LSP: Run CodeLens", { buffer = args.buf })
          keybind.set({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, "LSP: Refresh and Display CodeLens", { buffer = args.buf })
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          volar_takeover(args)
          setup_keybindings(args)
        end,
      })
    end,
  },
}
