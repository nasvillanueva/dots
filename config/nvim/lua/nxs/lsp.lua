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

for _, server_name in ipairs(get_mason_servers()) do
  local nxs_lsp_config = NXS_LSP_CONFIG[server_name] or {}

  lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
    capabilities = lsp_capabilities,
  }, nxs_lsp_config))
end
