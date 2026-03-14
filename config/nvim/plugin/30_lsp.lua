vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "luasnip" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("luasnip")
      end

      vim.fn.system({ "make", "install_jsregexp", "-C", ev.data.path })
    end
  end,
})

local setup_deferred = _G.nxs.deferred_packadd({
  {
    src = _G.nxs.gh("chrisgrieser/nvim-early-retirement"),
    name = "early-retirement",
  },

  _G.nxs.gh("rafamadriz/friendly-snippets"),
  { src = _G.nxs.gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") },

  _G.nxs.gh("folke/lazydev.nvim"),

  _G.nxs.gh("mason-org/mason.nvim"),
  _G.nxs.gh("mason-org/mason-lspconfig.nvim"),
  _G.nxs.gh("neovim/nvim-lspconfig"),

  _G.nxs.gh("onsails/lspkind.nvim"),
  _G.nxs.gh("alexandre-abrioux/blink-cmp-npm.nvim"),
  _G.nxs.gh("kristijanhusak/vim-dadbod-completion"),
  { src = _G.nxs.gh("saghen/blink.cmp"), version = vim.version.range("1.*") },

  _G.nxs.gh("stevearc/conform.nvim"),
})

setup_deferred(function()
  -- ==================================================================== early-retirement
  require("early-retirement").setup({})

  -- ==================================================================== luasnip
  require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.fn.stdpath("config") .. "/snippets",
  })
  require("luasnip.loaders.from_vscode").lazy_load()

  -- ==================================================================== lazydev
  require("lazydev").setup({
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })

  -- ==================================================================== mason
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "cssls",
      "tailwindcss",
      "eslint",
      "svelte",
      "jsonls",
      "stylelint_lsp",
      "lua_ls",
      "elixirls",
      "vtsls",
      "vue_ls",
    },
    automatic_installation = true,
  })

  -- ==================================================================== lspconfig
  _G.nxs.keybind_set("n", "<leader>cli", "<cmd>LspInfo<CR>", "LSP: Info")
  _G.nxs.keybind_set("n", "<leader>clr", "<cmd>LspRestart<CR>", "LSP: Restart")

  -- ==================================================================== blink
  local blink = require("blink-cmp")
  local lspkind = require("lspkind")
  local devicons = require("nvim-web-devicons")

  blink.setup({
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "hide" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-u>"] = {
        "scroll_documentation_up",
        "fallback",
      },
      ["<C-d>"] = {
        "scroll_documentation_down",
        "fallback",
      },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      ["<C-h>"] = {
        function(cmp)
          return cmp.select_prev({ count = 5 })
        end,
        "fallback",
      },
      ["<C-l>"] = {
        function(cmp)
          return cmp.select_next({ count = 5 })
        end,
        "fallback",
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    snippets = {
      preset = "luasnip",
    },
    sources = {
      default = { "lsp", "path", "snippets" },
      per_filetype = {
        sql = { "dadbod", "snippets", "buffer" },
        lua = { inherit_defaults = true, "lazydev" },
        json = { inherit_defaults = true, "npm" },
      },
      providers = {
        path = {
          opts = {
            show_hidden_files_by_default = true,
            ignore_root_slash = false,
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        snippets = {
          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
          end,
        },
        npm = {
          name = "npm",
          module = "blink-cmp-npm",
          async = true,
          score_offset = 100,
          opts = {
            ignore = {},
            only_semantic_versions = true,
            only_latest_version = false,
          },
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    fuzzy = {
      implementation = "prefer_rust",
    },
    completion = {
      keyword = { range = "full" },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      accept = {
        auto_brackets = { enabled = false },
      },
      menu = {
        max_height = 15,
        min_width = 20,
        draw = {
          treesitter = {
            "lsp",
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = devicons.get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end

                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = devicons.get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },
  })

  -- ==================================================================== conform
  require("conform").setup({
    formatters_by_ft = {
      ["*"] = { "trim_whitespace" },
      lua = { "stylua" },
      elixir = { "mix" },
      css = { "stylelint" },
      json = { "fixjson" },
      -- disable formatter to let autocmd eslint run instead
      javascript = {},
      javascriptreact = {},
      typescript = {},
      typescriptreact = {},
      vue = {},
      svelte = {},
    },
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  })

  vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

  _G.nxs.keybind_set("", "<leader>=", function()
    require("conform").format({ async = true, lsp_fallback = true }, function()
      vim.cmd("w!")
    end)
  end, "Code: Format Buffer")
end)

_G.nxs.new_autocmd("LspAttach", "*", function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if client:supports_method("textDocument/documentSymbols") then
    _G.nxs.keybind_set("n", "<leader>ss", function()
      Snacks.picker.lsp_symbols()
    end, "Picker: LSP Symbols")
  end

  if client:supports_method("workspace/symbol") then
    _G.nxs.keybind_set("n", "<leader>sS", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "Picker: LSP Workspace Symbols")
  end

  if client:supports_method("textDocument/declaration") then
    _G.nxs.keybind_set("n", "gD", function()
      Snacks.picker.lsp_declarations()
    end, "LSP: Goto declaration", { buffer = args.buf })
  end
  if client:supports_method("textDocument/implementation") then
    _G.nxs.keybind_set("n", "gI", function()
      Snacks.picker.lsp_implementations()
    end, "LSP: Goto Implementation")
  end
  if client:supports_method("textDocument/typeDefinition") then
    _G.nxs.keybind_set("n", "gy", function()
      Snacks.picker.lsp_type_definitions()
    end, "LSP: Goto Type Definition")
  end

  if client:supports_method("textDocument/hover") then
    _G.nxs.keybind_set(
      "n",
      "K",
      vim.lsp.buf.hover,
      "LSP: Hover",
      { buffer = args.buf }
    )
  end

  if client:supports_method("textDocument/definition") then
    _G.nxs.keybind_set("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, "LSP: Goto definition", { buffer = args.buf })
  end

  if client:supports_method("textDocument/references") then
    _G.nxs.keybind_set(
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

  if client:supports_method("textDocument/signatureHelp") then
    _G.nxs.keybind_set(
      "n",
      "gK",
      vim.lsp.buf.signature_help,
      "LSP: Signature Help",
      { buffer = args.buf }
    )
    _G.nxs.keybind_set(
      "i",
      "<C-k>",
      vim.lsp.buf.signature_help,
      "LSP: Signature Help",
      { buffer = args.buf }
    )
  end

  if client:supports_method("textDocument/codeAction") then
    _G.nxs.keybind_set(
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      "LSP: Code Actions",
      { buffer = args.buf }
    )

    _G.nxs.keybind_set("n", "<leader>cA", function()
      vim.lsp.buf.code_action({
        context = { only = { "source" }, diagnostics = {} },
      })
    end, "LSP: Source Action", { buffer = args.buf })
  end

  if client:supports_method("textDocument/rename") then
    _G.nxs.keybind_set(
      "n",
      "<leader>cr",
      vim.lsp.buf.rename,
      "LSP: Rename",
      { buffer = args.buf }
    )
  end

  if client:supports_method("textDocument/codeLens") then
    _G.nxs.keybind_set(
      { "n", "v" },
      "<leader>cc",
      vim.lsp.codelens.run,
      "LSP: Run CodeLens",
      { buffer = args.buf }
    )
    _G.nxs.keybind_set(
      { "n", "v" },
      "<leader>cC",
      vim.lsp.codelens.refresh,
      "LSP: Refresh and Display CodeLens",
      { buffer = args.buf }
    )
  end
end, "Setup keybind for LSP")
