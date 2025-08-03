return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      require("nxs.plugins.snippets"),
      "onsails/lspkind.nvim",
      "nvim-tree/nvim-web-devicons",
      "alexandre-abrioux/blink-cmp-npm.nvim",
    },
    config = function()
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
          default = { "lazydev", "lsp", "path", "snippets", "npm" },
          providers = {
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
            path = {
              opts = {
                get_cwd = function(_)
                  return vim.fn.getcwd()
                end,
              },
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
    end,
  },
}
