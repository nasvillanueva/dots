local keybind = require("nxs.utils.keybind")
local lsp = require("nxs.utils.lsp")

-- TODO: Move this to separate server files
local NXS_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {
    filetypes = { "vue", "html", "css", "scss" },
  },
  eslint = {},
  svelte = {},
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
          globals = { "vim", "Snacks" },
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
  },
  elixirls = {
    before_init = function(_, config)
      config.cmd = {
        vim.fn.expand("$MASON/bin/elixir-ls"),
      }
    end,
  },
  vtsls = {
    before_init = function(_, config)
      config.settings.vtsls.tsserver.globalPlugins = {
        {
          name = "@vue/typescript-plugin",
          languages = { "vue" },
          location = vim.fn.expand(
            "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
          ),
          configNamespace = "typescript",
        },
      }
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
        tsserver = {
          globalPlugins = {},
        },
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = true,
          },
        },
      },
      javascript = {
        format = { enable = false },
        referencesCodeLens = { enabled = false },
      },
      typescript = {
        format = { enable = false },
        referencesCodeLens = { enabled = false },
        implementationsCodeLens = { enabled = false },
        preferences = {
          includePackageJsonAutoImports = "off",
        },
      },
    },
  },
  vue_ls = {
    init_options = {
      typescript = {},
    },
    settings = {
      scss = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
      vue = {
        suggest = {
          componentNameCasing = "alwaysPascalCase",
          propNameCasing = "alwaysKebabCase",
        },
      },
    },
  },
}

return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      require("nxs.plugins.snacks"),
      require("nxs.plugins.cmp"),
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

      local get_mason_servers = require("mason-lspconfig").get_installed_servers

      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })

      for _, server_name in ipairs(get_mason_servers()) do
        local nxs_lsp_config = NXS_LSP_CONFIG[server_name] or {}

        vim.lsp.config(
          server_name,
          vim.tbl_deep_extend("force", nxs_lsp_config, {
            capabilities = require("blink.cmp").get_lsp_capabilities(
              nxs_lsp_config.capabilities
            ),
          })
        )
      end

      local function setup_keybindings(args)
        keybind.set("n", "<leader>cli", "<cmd>LspInfo<CR>", "LSP: Info")
        keybind.set("n", "<leader>clr", "<cmd>LspRestart<CR>", "LSP: Restart")

        keybind.set("n", "<leader>ss", function()
          Snacks.picker.lsp_symbols()
        end, "Picker: LSP Symbols")
        keybind.set("n", "<leader>sS", function()
          Snacks.picker.lsp_workspace_symbols()
        end, "Picker: LSP Workspace Symbols")

        keybind.set("n", "gD", function()
          Snacks.picker.lsp_declarations()
        end, "LSP: Goto declaration", { buffer = args.buf })
        keybind.set("n", "gI", function()
          Snacks.picker.lsp_implementations()
        end, "LSP: Goto Implementation")
        keybind.set("n", "gy", function()
          Snacks.picker.lsp_type_definitions()
        end, "LSP: Goto Type Definition")

        keybind.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          "LSP: Hover",
          { buffer = args.buf }
        )

        if lsp.supports("textDocument/definition", args) then
          keybind.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
          end, "LSP: Goto definition", { buffer = args.buf })
        end

        if lsp.supports("textDocument/References", args) then
          keybind.set(
            "n",
            "gr",
            function()
              Snacks.picker.lsp_references()
            end,
            "LSP: Find Usages",
            {
              buffer = args.buf,
              nowait = true,
            }
          )
        end

        if lsp.supports("textDocument/signatureHelp", args) then
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

        if lsp.supports("textDocument/codeAction", args) then
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

        if lsp.supports("textDocument/rename", args) then
          keybind.set(
            "n",
            "<leader>cr",
            vim.lsp.buf.rename,
            "LSP: Rename",
            { buffer = args.buf }
          )
        end

        if lsp.supports("textDocument/codeLens", args) then
          keybind.set(
            { "n", "v" },
            "<leader>cc",
            vim.lsp.codelens.run,
            "LSP: Run CodeLens",
            { buffer = args.buf }
          )
          keybind.set(
            { "n", "v" },
            "<leader>cC",
            vim.lsp.codelens.refresh,
            "LSP: Refresh and Display CodeLens",
            { buffer = args.buf }
          )
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = setup_keybindings,
      })
    end,
  },
}
