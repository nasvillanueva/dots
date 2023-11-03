local function is_git_project()
  local _, ret, _ = require("telescope.utils").get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  return ret == 0
end

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
        ":Telescope live_grep<CR>",
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
        defaults = require("telescope.themes").get_dropdown({
          preview = false,
        }),
        extensions = {
          ["ui-select"] = {
            codeactions = false,
          },
        },
      })
    end,
    init = function()
      local telescope = require("telescope")
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")

      if is_git_project() then
        vim.keymap.set(
          "n",
          "<leader>o",
          ":Telescope git_files show_untracked=true<CR>",
          { silent = true, desc = "Telescope: Find Git Files" }
        )
        vim.keymap.set(
          "n",
          "<leader>9",
          ":Telescope git_status<CR>",
          { silent = true, desc = "Telescope: Find Modified Files" }
        )
      else
        vim.keymap.set(
          "n",
          "<leader>o",
          ":Telescope find_files<CR>",
          { silent = true, desc = "Telescope: Find Files" }
        )
      end
    end,
  },
}
