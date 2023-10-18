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
        desc = "Telescope: Buffers",
        silent = true,
      },
      {
        "<leader>o",
        ":Telescope git_files<CR>",
        mode = "n",
        desc = "Telescope: Git Files",
        silent = true,
      },
      {
        "<leader>O",
        ":Telescope find_files<CR>",
        mode = "n",
        desc = "Telescope: Find Files",
        silent = true,
      },
      {
        "<leader>F",
        ":Telescope grep_string only_sort_text=true search=<CR>",
        mode = "n",
        desc = "Telescope: Find String",
        silent = true,
      },
      {
        "<leader><C-o>",
        ":Telescope lsp_document_symbols<CR>",
        mode = "n",
        desc = "Telescop: Find Symbols",
        silent = true,
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
