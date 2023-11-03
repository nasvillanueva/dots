return {
  {
    "nvim-tree/nvim-tree.lua",
    main = "nvim-tree",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>1",
        function()
          local nvim_tree = require("nvim-tree.api")
          local current_buf = vim.api.nvim_get_current_buf()
          local current_buf_ft =
            vim.api.nvim_get_option_value("filetype", { buf = current_buf })

          if current_buf_ft == "NvimTree" then
            nvim_tree.tree.toggle()
          else
            nvim_tree.tree.focus()
          end
        end,
        mode = "n",
        desc = "Explorer: Toggle or Focus",
      },
      {
        "<leader>4",
        ":NvimTreeFindFile<CR>",
        mode = "n",
        desc = "Explorer: Focus File",
      },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        renderer = {
          group_empty = true,
        },
        view = {
          width = 40,
        },
        on_attach = function(bufnr)
          local nvim_tree = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "Explorer: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          nvim_tree.config.mappings.default_on_attach(bufnr)

          local function get_telescope_opts()
            local node = nvim_tree.tree.get_node_under_cursor()
            local is_folder = node.fs_stat and node.fs_stat.type == "directory"
              or false
            local basedir = is_folder and node.absolute_path
              or vim.fn.fnamemodify(node.absolute_path, ":h")

            return {
              cwd = basedir,
              search_dirs = { basedir },
            }
          end

          vim.keymap.set("n", "f", function()
            require("telescope.builtin").live_grep(get_telescope_opts())
          end, opts("Find string in folder"))

          vim.keymap.set("n", "F", function()
            require("telescope.builtin").find_files(get_telescope_opts())
          end, opts("Find file in folder"))
        end,
      })
    end,
  },
}
