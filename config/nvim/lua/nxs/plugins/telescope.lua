local keybind = require("nxs.utils.keybind")

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local telescope_actions = require("telescope.actions")

      telescope.setup({
        defaults = require("telescope.themes").get_ivy({
          sorting_strategy = "descending",
          layout_config = { prompt_position = "bottom" },
          mappings = {
            i = {
              ["<ESC>"] = telescope_actions.close,
              ["<C-\\><C-\\>"] = function()
                vim.cmd("stopinsert")
              end,
            },
          },
        }),
        extensions = {
          ["ui-select"] = {
            codeactions = false,
          },
        },
        pickers = {
          live_grep = {
            preview = true,
          },
          buffers = {
            mappings = {
              i = {
                ["<C-d>"] = telescope_actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")

      keybind.set(
        "n",
        "<leader><leader>",
        ":Telescope find_files<CR>",
        "Telescope: Find Files"
      )
      keybind.set(
        "n",
        "<leader>fg",
        ":Telescope git_files show_untracked=true<CR>",
        "Telescope: Find Git Files"
      )
      keybind.set(
        "n",
        "<leader>gs",
        ":Telescope git_status<CR>",
        "Telescope: Find Modified Files"
      )

      keybind.set(
        "n",
        "<leader>`",
        ":Telescope buffers<CR>",
        "Telescope: Buffers"
      )
      keybind.set(
        "n",
        "<leader>/",
        ":Telescope live_grep<CR>",
        "Telescope: Find String"
      )
      keybind.set(
        "n",
        "<leader>cs",
        ":Telescope lsp_document_symbols<CR>",
        "Telescope: Find Symbols"
      )
    end,
  },
}
