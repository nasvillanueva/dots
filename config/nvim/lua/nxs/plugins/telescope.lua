return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    keys = {
      {
        "<leader>`",
        ":Telescope buffers<CR>",
        mode = "n",
        desc = "Open Telescope: Buffers"
      },
      -- Do I need this?
      -- { "`g", ":Telescope git_files<CR>", mode = "n", desc = "Open Telescope: Git Files" },
      {
        "<leader>p",
        ":Telescope find_files<CR>",
        mode = "n",
        desc = "Open Telescope: Find Files"
      },
      {
        "<leader>F",
        ":Telescope grep_string only_sort_text=true search=<CR>",
        mode = "n",
        desc = "Open Telescope: Find String"
      },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
            codeactions = false,
          }
        }
      })
    end,
    init = function()
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end
  },
}
