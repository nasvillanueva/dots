return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("blink-cmp").setup({
        keymap = {
          preset = "none",
          ["<C-space>"] = { "show" },
          ["<Tab>"] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
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

                return cmp.select_next({ auto_insert = has_words_before() })
              end
            end,
            "snippet_forward",
            "fallback",
          },
          ["<S-Tab>"] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.snippet_backward()
              else
                return cmp.select_prev()
              end
            end,
            "fallback",
          },
          ["<CR>"] = { "accept", "fallback" },
          ["<C-k>"] = {
            "scroll_documentation_up",
            "fallback",
          },
          ["<C-j>"] = {
            "scroll_documentation_down",
            "fallback",
          },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust" },
        completion = {
          keyword = { range = "full" },
          list = {
            selection = {
              preselect = false,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
          accept = {
            auto_brackets = { enabled = true },
          },
          menu = {
            draw = {
              treesitter = {
                "lsp",
              },
            },
          },
          trigger = {
            prefetch_on_insert = true,
          },
        },
      })
    end,
  },
}
