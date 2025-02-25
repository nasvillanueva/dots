local keybind = require("nxs.utils.keybind")
local lsp = require("nxs.utils.lsp")

-- TODO: Move this to separate server files
local NXS_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {
    filetypes = { "vue", "html", "css", "scss" },
  },
  eslint = {},
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
    -- provide cmd in nvim-lspconfig config function
  },
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "", -- set in nvim-lspconfig config function
          languages = { "vue" },
        },
      },
    },
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
    },
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
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
  volar = {
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
        inlayHints = {
          missingProps = true,
          inlineHandlerLeading = false,
          optionsWrapper = false,
          vBindShorthand = false,
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
      { "folke/snacks.nvim" },
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

      local Snacks = require("snacks")
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local get_mason_servers = require("mason-lspconfig").get_installed_servers
      local mason_registry = require("mason-registry")

      local vue_language_server_path = mason_registry
        .get_package("vue-language-server")
        :get_install_path() .. "/node_modules/@vue/language-server"
      local elixirls_server_path = mason_registry
        .get_package("elixir-ls")
        :get_install_path() .. "/language_server.sh"

      for _, server_name in ipairs(get_mason_servers()) do
        local nxs_lsp_config = NXS_LSP_CONFIG[server_name] or {}

        if server_name == "elixirls" then
          nxs_lsp_config.cmd = { elixirls_server_path }
        elseif server_name == "ts_ls" then
          nxs_lsp_config.init_options.plugins[1].location =
            vue_language_server_path
        end

        lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
          capabilities = lsp_capabilities,
        }, nxs_lsp_config))
      end

      local function setup_keybindings(args)
        keybind.set("n", "<leader>cli", "<cmd>LspInfo<CR>", "LSP: Info")
        keybind.set("n", "<leader>clr", "<cmd>LspRestart<CR>", "LSP: Restart")

        keybind.set("n", "<leader>ss", function()
          Snacks.picker.lsp_symbols()
        end, "LSP Symbols")
        keybind.set("n", "<leader>sS", function()
          Snacks.picker.lsp_workspace_symbols()
        end, "LSP Workspace Symbols")

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

        if lsp.supports("textDocument/definition", args.data.client_id) then
          keybind.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
          end, "LSP: Goto definition", { buffer = args.buf })
        end

        if lsp.supports("textDocument/References", args.data.client_id) then
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

        if lsp.supports("textDocument/signatureHelp", args.data.client_id) then
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

        if lsp.supports("textDocument/codeAction", args.data.client_id) then
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

        if lsp.supports("textDocument/rename", args.data.client_id) then
          keybind.set(
            "n",
            "<leader>cr",
            vim.lsp.buf.rename,
            "LSP: Rename",
            { buffer = args.buf }
          )
        end

        if lsp.supports("textDocument/codeLens", args.data.client_id) then
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
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if
            client ~= nil
            and vim.fn.getbufvar(args.buf, "&filetype") ~= "vue"
            and lsp.supports("textDocument/inlayHint", args.data.client_id)
            and vim.api.nvim_buf_is_valid(args.data.client_id)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          setup_keybindings(args)
        end,
      })
    end,
  },
}
