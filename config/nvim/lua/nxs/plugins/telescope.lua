local keybind = require("nxs.utils.keybind")

return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "smartpde/telescope-recent-files" },
    },
    config = function()
      local telescope = require("telescope")
      local telescope_actions = require("telescope.actions")

      local trouble_actions = require("trouble.providers.telescope")

      telescope.setup({
        defaults = require("telescope.themes").get_dropdown({
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              mirror = true,
              prompt_position = "top",
              preview_height = 0.3
            },
            height = 0.80,
            width = 0.87,
          },
          mappings = {
            i = {
              ["<ESC>"] = telescope_actions.close,
              ["<C-\\><C-\\>"] = function()
                vim.cmd("stopinsert")
              end,
              ["<C-t>"] = trouble_actions.smart_open_with_trouble,
            },
            n = {
              ["<C-t>"] = trouble_actions.smart_open_with_trouble,
            },
          },
          path_display = {
            filename_first = {
              reverse_directories = true,
            },
          },
        }),
        extensions = {
          ["ui-select"] = {
            codeactions = false,
          },
          fzf = {
            fuzzy = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          recent_files = {
            only_cwd = true,
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
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("recent_files")

      keybind.set(
        "n",
        "<leader>/",
        "<CMD>Telescope live_grep<CR>",
        "Telescope: Search"
      )
      keybind.set(
        "n",
        "<leader>:",
        "<CMD>Telescope command_history<CR>",
        "Telescope: Command History"
      )

      -- files
      keybind.set(
        "n",
        "<leader><leader>",
        "<CMD>Telescope git_files show_untracted=true<CR>",
        "Telescope: Git Files"
      ) -- TODO: Conditionally trigger git_files based on directory is git project
      keybind.set(
        "n",
        "<leader>fb",
        "<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>",
        "Telescope: Buffers"
      )
      keybind.set(
        "n",
        "<leader>fg",
        "<CMD>Telescope git_files show_untracted=true<CR>",
        "Telescope: Git Files"
      )
      keybind.set(
        "n",
        "<leader>ff",
        "<CMD>Telescope find_files<CR>",
        "Telescope: Files"
      )
      keybind.set("n", "<leader>fr", function()
        require("telescope").extensions.recent_files.pick()
      end, "Telescope: Recent Files")

      -- git
      keybind.set(
        "n",
        "<leader>gc",
        "<CMD>Telescope git_commits<CR>",
        "Telescope: Git Commits"
      )
      keybind.set(
        "n",
        "<leader>gs",
        "<CMD>Telescope git_status<CR>",
        "Telescope: Git Status"
      )

      -- search
      keybind.set(
        "n",
        '<leader>s"',
        "<CMD>Telescope registers<CR>",
        "Telescope: Registers"
      )
      keybind.set(
        "n",
        "<leader>sb",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        "Telescope: Current Buffer Fuzzy Find"
      )
      keybind.set(
        "n",
        "<leader>sk",
        "<CMD>Telescope keymaps<CR>",
        "Telescope: Keymaps"
      )
      keybind.set(
        "n",
        "<leader>sm",
        "<CMD>Telescope marks<CR>",
        "Telescope: Marks"
      )
      keybind.set(
        "n",
        "<leader>sR",
        "<CMD>Telescope resume<CR>",
        "Telescope: Resume last search"
      )

      -- Code
      keybind.set(
        "n",
        "<leader>cs",
        "<CMD>Telescope lsp_document_symbols<CR>",
        "Telescope: LSP Symbols"
      )
      keybind.set(
        "n",
        "<leader>cS",
        "<CMD>Telescope lsp_workspace_symbols<CR>",
        "Telescope: LSP Symbols (Workspace)"
      )
    end,
  },
}
