return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      require("nxs.plugins.luasnip"),
      require("nxs.plugins.lspkind"),
    },
    config = function()
      local cmp = require("cmp")
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
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
      local cmp_prev = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end

      cmp.setup({
        completion = {
          autocomplete = false,
        },
        formatting = {
          format = lsp_kind.cmp_format(),
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
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
            name = "nvim_lsp",
            group_index = 1,
          },
          { name = "path", group_index = 2 },
          {
            name = "luasnip",
            max_item_count = 5,
            group_index = 3,
          },
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Disables copilot suggestions when cmp menu is open
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
}
