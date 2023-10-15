local NXS_LSP_CONFIG = {
  cssls = {},
  tailwindcss = {},
  eslint = {},
  tsserver = {
    on_attach = function()
      vim.keymap.set("", "<leader>o", ":OrganizeImports<CR>")
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
    filetypes = { 'vue', 'typescript' },
    settings = {
      scss = {
        lint = {
          unknownAtRules = 'ignore',
        },
      }
    },
  },
  jsonls = { filetypes = { 'json', 'jsonc' } },
  stylelint_lsp = {
    settings = {
      stylelintplus = {
        autoFixOnFormat = true,
      }
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
      }
    },
  },
}

return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
    },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      require("copilot_cmp").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "zbirenbaum/copilot.lua" },
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = {
          ['<C-space>'] = cmp.mapping.complete(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<CR>'] = cmp.mapping.confirm(),
          -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-u>'] = cmp.mapping.scroll_docs(4),
          ['<C-c>'] = cmp.mapping.close(),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
          { name = "copilot" },
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
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
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local get_mason_servers = require("mason-lspconfig").get_installed_servers

      for _, server_name in ipairs(get_mason_servers()) do
        local nxs_lsp_config = NXS_LSP_CONFIG[server_name]
        if nxs_lsp_config == nil then
          nxs_lsp_config = {}
        end

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
        vim.keymap.set("n", "<leader>lsp", ":silent :LspRestart<CR>", { desc = "LSP: Restart" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "LSP: Hover" })
        vim.keymap.set("n", "!", vim.diagnostic.open_float, { desc = "LSP: View Error" })
        vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, { desc = "LSP: Code Actions" })
        vim.keymap.set("n", "<leader>b", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
        vim.keymap.set("n", "<leader>&", vim.lsp.buf.references, { desc = "LSP: Find Usages" })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = "nxs",
        callback = function(args)
          volar_takeover(args)
          setup_keybindings(args)
        end
      })
    end,
  },
  {
    "stevearc/conform.nvim", -- formatter
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {

        "<leader>=",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format Buffer",
      },
    },
    opts = {
      lua = { "stylelua" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      vue = { { "prettierd", "prettier" } },
      ["*"] = { "codespell", "trim_whitespace" },
    },
    init = function()
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
  },
}
