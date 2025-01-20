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

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
    version = "*",
    opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            elseif vim.snippet.active({ direction = 1 }) then
              vim.snippet.jump(1)
              return true
            elseif has_words_before() then
              return cmp.show()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.snippet.jump(-1)
              return true
            end
          end,
          "fallback",
        },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-k>"] = { "scroll_documentation_up", "fallback" },
        ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-d>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next()
              cmp.select_next()
              cmp.select_next()
              cmp.select_next()
              return true
            end
          end,
          "fallback",
        },
        ["<C-u>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev()
              cmp.select_prev()
              cmp.select_prev()
              cmp.select_prev()
              return true
            end
          end,
          "fallback",
        },
        ["<Up>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            end
          end,
          "fallback",
        },
        ["<Down>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end
          end,
          "fallback",
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" then
            return { "cmdline" }
          end
          return {}
        end,
        providers = {
          -- lazydev configured in nxs.plugins.lsp
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          update_delay_ms = 50,
          treesitter_highlighting = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        trigger = {
          prefetch_on_insert = true,
        },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}
