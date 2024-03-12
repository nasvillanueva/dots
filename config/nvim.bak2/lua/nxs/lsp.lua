local keybind = require("nxs.utils.keybind")
local lazyload = require("nxs.utils.lazyload")

lazyload.add(function()
  vim.cmd.packadd("nvim-lsp-file-operations")
  require("lsp-file-operations").setup({})
end)

lazyload.add(function()
  vim.cmd.packadd("confirm.nvim")
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      elixir = { "mix" },
      ["*"] = { "codespell", "trim_whitespace" },
    },
  })

  vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

  keybind.set("", "<leader>=", function()
    require("conform").format({ async = true, lsp_fallback = true }, function()
      vim.cmd("w!")
    end)
  end, "LSP: Format")
end)

require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  sources = {
    { name = "nvim_lsp", group_index = 1 },
    { name = "path", group_index = 1 },
  },
  mapping = {
    ["<C-space>"] = cmp.mapping.complete(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    -- ["<Up>"] = cmp.mapping.select_prev_item(),
    -- ["<Down>"] = cmp.mapping.select_next_item(),
    ["<CR>"] = cmp.mapping.confirm(),
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>"] = cmp.mapping.close(),
  },
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local get_mason_servers = require("mason-lspconfig").get_installed_servers

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
}

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
  keybind.set("n", "<leader>lsp", ":silent :LspRestart<CR>", "LSP: Restart")
  vim.keymap.set(
    "n",
    "<leader>ck",
    vim.lsp.buf.hover,
    { buffer = args.buf, desc = "LSP: Hover" }
  )
  keybind.set("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Actions")
  keybind.set("n", "<leader>cr", vim.lsp.buf.rename, "LSP: Rename")
  keybind.set(
    "n",
    "<leader>cd",
    vim.lsp.buf.definition,
    "LSP: Go to Definition"
  )
  keybind.set("n", "<leader>cu", vim.lsp.buf.references, "LSP: Find Usages")
  keybind.set(
    "n",
    "<leader>ch",
    vim.lsp.buf.signature_help,
    "LSP: Show Signature Help"
  )
  keybind.set("n", "<leader>ce", vim.diagnostic.open_float, "LSP: View Error")
  keybind.set(
    "n",
    "<leader>c[",
    vim.diagnostic.goto_prev,
    "LSP: Goto Previous Diagnostic Error"
  )
  keybind.set(
    "n",
    "<leader>c]",
    vim.diagnostic.goto_next,
    "LSP: Goto Next Diagnostic Error"
  )
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    volar_takeover(args)
    setup_keybindings(args)
  end,
})
