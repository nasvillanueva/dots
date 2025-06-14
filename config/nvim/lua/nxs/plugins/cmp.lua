return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local blink = require("blink-cmp")
      blink.setup({
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
        fuzzy = {
          implementation = "prefer_rust",
          sorts = {
            "exact",
            -- Deprioritize emmet_ls
            function(a, b)
              if
                (a.client_name == nil or b.client_name == nil)
                or (a.client_name == b.client_name)
              then
                return
              end
              return b.client_name == "emmet_ls"
            end,
            "score",
            "sort_text",
          },
        },
        completion = {
          keyword = { range = "full" },
          list = {
            selection = {
              preselect = function()
                return not blink.snippet_active({
                  direction = 1,
                })
              end,
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
        },
      })
    end,
  },
}
