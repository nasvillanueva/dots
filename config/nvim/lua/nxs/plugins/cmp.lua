return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "windwp/nvim-autopairs",
      "LuaSnip", -- points to the already-initialized config in nxs.plugins.luasnip
      "copilot.lua", -- points to the already-initialized config in nxs.plugins.copilot
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lsp_kind = require("lspkind")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end
      local cmp_next = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
      local cmp_prev = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      lsp_kind.init()
      cmp.setup({
        formatting = {
          format = lsp_kind.cmp_format(),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-space>"] = cmp.mapping.complete(),
          ["<S-Tab>"] = cmp.mapping(cmp_prev),
          ["<Tab>"] = cmp.mapping(cmp_next),
          ["<CR>"] = cmp.mapping.confirm(),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.close(),
        },
        sources = {
          { name = "nvim_lsp_signature_help", group_index = 1 },
          {
            name = "luasnip",
            max_item_count = 5,
            group_index = 1,
          },
          {
            name = "nvim_lsp",
            max_item_count = 20,
            group_index = 1,
          },
          { name = "path", group_index = 2 },
          { name = "copilot", group_index = 3 },
        },
      })

      local autopairs_present, cmp_autopairs =
        pcall(require, "nvim-autopairs.completion.cmp")
      if not autopairs_present then
        return
      end
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
      )
    end,
  },
}
