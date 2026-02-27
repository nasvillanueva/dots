MiniDeps.later(function()
  MiniDeps.add({ source = "lewis6991/gitsigns.nvim" })

  require("gitsigns").setup({
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

      _G.nxs.keybind_set("n", "]h", gs.next_hunk, "Next Hunk")
      _G.nxs.keybind_set("n", "[h", gs.prev_hunk, "Prev Hunk")
      _G.nxs.keybind_set(
        { "n", "v" },
        "<leader>ghs",
        ":Gitsigns stage_hunk<CR>",
        "Stage Hunk"
      )
      _G.nxs.keybind_set(
        { "n", "v" },
        "<leader>ghr",
        ":Gitsigns reset_hunk<CR>",
        "Reset Hunk"
      )
      _G.nxs.keybind_set("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      _G.nxs.keybind_set(
        "n",
        "<leader>ghu",
        gs.undo_stage_hunk,
        "Undo Stage Hunk"
      )
      _G.nxs.keybind_set("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      _G.nxs.keybind_set(
        "n",
        "<leader>ghp",
        gs.preview_hunk_inline,
        "Preview Hunk Inline"
      )
      _G.nxs.keybind_set("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      _G.nxs.keybind_set("n", "<leader>ghd", gs.diffthis, "Diff This")
      _G.nxs.keybind_set("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      _G.nxs.keybind_set(
        { "o", "x" },
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        "GitSigns Select Hunk"
      )
    end,
  })
end)

MiniDeps.later(function()
  MiniDeps.add({ source = "sindrets/diffview.nvim" })

  require("diffview").setup()
  _G.nxs.keybind_set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", "DiffView")
end)

MiniDeps.later(function()
  MiniDeps.add({
    source = "ruifm/gitlinker.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

  require("gitlinker").setup()
end)
