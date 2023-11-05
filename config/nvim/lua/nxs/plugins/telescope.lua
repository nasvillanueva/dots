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
        defaults = require("telescope.themes").get_dropdown({
          preview = false,
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
                ["<C-q>"] = telescope_actions.delete_buffer,
              }
            }
          }
        },
      })

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

      vim.keymap.set(
        "n",
        "<leader>`",
        ":Telescope buffers<CR>",
        { silent = true, desc = "Telescope: Buffers" }
      )
      vim.keymap.set(
        "n",
        "<leader>F",
        ":Telescope live_grep<CR>",
        { silent = true, desc = "Telescope: Find String" }
      )
      vim.keymap.set(
        "n",
        "<leader>cs",
        ":Telescope lsp_document_symbols<CR>",
        { silent = true, desc = "Telescope: Find Symbols" }
      )
    end,
  },
}
