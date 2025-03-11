local keybind = require("nxs.utils.keybind")

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        keybind.set("n", "]h", gs.next_hunk, "Next Hunk")
        keybind.set("n", "[h", gs.prev_hunk, "Prev Hunk")
        keybind.set(
          { "n", "v" },
          "<leader>ghs",
          ":Gitsigns stage_hunk<CR>",
          "Stage Hunk"
        )
        keybind.set(
          { "n", "v" },
          "<leader>ghr",
          ":Gitsigns reset_hunk<CR>",
          "Reset Hunk"
        )
        keybind.set("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        keybind.set("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        keybind.set("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        keybind.set(
          "n",
          "<leader>ghp",
          gs.preview_hunk_inline,
          "Preview Hunk Inline"
        )
        keybind.set("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        keybind.set("n", "<leader>ghd", gs.diffthis, "Diff This")
        keybind.set("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        keybind.set(
          { "o", "x" },
          "ih",
          ":<C-U>Gitsigns select_hunk<CR>",
          "GitSigns Select Hunk"
        )
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    init = function()
      keybind.set("n", "<leader>ge", "<cmd>DiffViewOpen<CR>", "DiffView")
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
}
