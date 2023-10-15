local function init_mason()
  require("mason").setup()
  require("mason-lspconfig").setup({
    handlers = {
      require("lsp-zero").default_setup,
    }
  })
end

local function init_cmp()
  local cmp = require("cmp")

  cmp.setup({
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
    },
  })
end

local function init_lsp()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lsp_zero = require("lsp-zero")

  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
  end)

  local LSP_SERVERS = {
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
  }

  for server, config in pairs(LSP_SERVERS) do
    lspconfig[server].setup(vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      ),
    }, config))
  end

  -- Volar Takeover mode
  -- https://vuejs.org/guide/typescript/overview.html#volar-takeover-mode
  local volar_client = nil
  local tsserver_client = nil

  vim.api.nvim_create_autocmd("LspAttach", {
    group = "nxs",
    callback = function(data)
      local client = vim.lsp.get_client_by_id(data.client_id)

      if client == nil then
        return
      end

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
  })
end

return {
  { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
  { "williamboman/mason.nvim" },           -- package manager for lsp servers
  { "williamboman/mason-lspconfig.nvim" }, -- lspconfig integration for mason
  { "hrsh7th/nvim-cmp" },                  -- completion
  { "hrsh7th/cmp-buffer" },                -- words in current buffer
  { "hrsh7th/cmp-path" },                  -- file paths
  { "hrsh7th/cmp-nvim-lsp" },              -- lsp
  {
    "neovim/nvim-lspconfig",
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
      init_mason()
      init_cmp()
      init_lsp()
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
