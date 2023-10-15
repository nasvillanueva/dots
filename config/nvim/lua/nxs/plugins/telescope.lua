return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
    init = function()
      require("telescope").load_extension("fzf")
    end
  },
}
