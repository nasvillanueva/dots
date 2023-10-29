local utils = require("nxs.utils")

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
        defaults = {
          layout_strategy = "bottom_pane",
          sorting_strategy = "ascending",
          layout_config = { height = 0.4 },
          border = false,
          preview = false,
        },
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

      if utils.is_git_project() then
        vim.keymap.set("n", "<leader>o", ":Telescope git_files show_untracked=true<CR>",
          { silent = true, desc = "Telescope: Find Git Files" })
        vim.keymap.set("n", "<leader>9", ":Telescope git_status<CR>",
          { silent = true, desc = "Telescope: Find Modified Files" })
      else
        vim.keymap.set("n", "<leader>o", ":Telescope find_files<CR>", { silent = true, desc = "Telescope: Find Files" })
      end
    end
  },
}
