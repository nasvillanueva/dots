local keybind = require("nxs.utils.keybind")

return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
        },
        view = {
          width = 30,
        },
        -- think about mapping
        --        on_attach = function(bufnr)
        --          local nvim_tree = require("nvim-tree.api")
        --
        --          nvim_tree.config.mappings.default_on_attach(bufnr)
        --
        --          local function get_telescope_opts()
        --            local node = nvim_tree.tree.get_node_under_cursor()
        --            local is_folder = node.fs_stat and node.fs_stat.type == "directory"
        --              or false
        --            local basedir = is_folder and node.absolute_path
        --              or vim.fn.fnamemodify(node.absolute_path, ":h")
        --
        --            return {
        --              cwd = basedir,
        --              search_dirs = { basedir },
        --            }
        --          end
        --
        --          keybind.set("n", "f", function()
        --            require("telescope.builtin").live_grep(get_telescope_opts())
        --          end, "Explorer: Find string in folder", { buffer = bufnr})
        --
        --          keybind.set("n", "F", function()
        --            require("telescope.builtin").find_files(get_telescope_opts())
        --          end, "Explorer: Find file in folder", { buffer = bufnr})
        --        end,
      })

      keybind.set("n", "<leader>e", function()
        local nvim_tree = require("nvim-tree.api")
        local current_buf = vim.api.nvim_get_current_buf()
        local current_buf_ft =
          vim.api.nvim_get_option_value("filetype", { buf = current_buf })

        if current_buf_ft == "NvimTree" then
          nvim_tree.tree.toggle()
        else
          nvim_tree.tree.focus()
        end
      end, "Explorer: Toggle or Focus")

      keybind.set(
        "n",
        "<leader>fE",
        ":NvimTreeFindFile<CR>",
        "Explorer: Focus File"
      )
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    name = "lsp-file-operations",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    opts = {},
  },
}
