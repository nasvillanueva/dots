local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("assistcontrol/readline.nvim"),
  _G.nxs.gh("gregorias/coop.nvim"),
  _G.nxs.gh("gregorias/coerce.nvim"),
  _G.nxs.gh("keaising/im-select.nvim"),
  _G.nxs.gh("rgroli/other.nvim"),
})

setup_deferred(function()
  -- ==================================================================== emacs-binding
  local readline = require("readline")
  _G.nxs.keybind_set(
    "!",
    "<M-f>",
    readline.forward_word,
    "Readline: Forward Word"
  )
  _G.nxs.keybind_set(
    "!",
    "<M-b>",
    readline.backward_word,
    "Readline: Backward Word"
  )
  _G.nxs.keybind_set(
    "!",
    "<C-a>",
    readline.beginning_of_line,
    "Readline: Beginning of Line"
  )
  _G.nxs.keybind_set(
    "!",
    "<C-e>",
    readline.end_of_line,
    "Readline: End of Line"
  )
  _G.nxs.keybind_set("!", "<M-d>", readline.kill_word, "Readline: Kill Word")
  _G.nxs.keybind_set(
    "!",
    "<M-BS>",
    readline.backward_kill_word,
    "Readline: Backward Kill Word"
  )
  _G.nxs.keybind_set(
    "!",
    "<C-w>",
    readline.unix_word_rubout,
    "Readline: Unix Word Rubout"
  )
  _G.nxs.keybind_set("!", "<C-k>", readline.kill_line, "Readline: Kill Line")
  _G.nxs.keybind_set(
    "!",
    "<C-u>",
    readline.backward_kill_line,
    "Readline: Backward Kill Line"
  )

  -- ==================================================================== coerce
  require("coerce").setup()
  local wke = require("coerce.keymaps").which_key_expand
  require("which-key").add({
    { "cr", group = "+Coerce word", expand = wke.normal_mode, mode = "n" },
    { "gcr", group = "+Coerce motion", expand = wke.motion_mode, mode = "n" },
    { "gcr", group = "+Coerce visual", expand = wke.visual_mode, mode = "x" },
  })

  -- ==================================================================== im-select
  require("im_select").setup({
    default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
    set_previous_events = {},
    async_switch_im = false,
    default_command = { "macism" },
  })

  -- ==================================================================== other.nvim
  local other = require("other-nvim")
  other.setup({
    showMissingFiles = false,
    mappings = {
      "elixir",

      {
        pattern = "src/(.*)%.(%w+)$",
        target = "tests/%1.spec.ts",
        context = "test",
      },
      {
        pattern = "tests/(.*)%.spec%.ts$",
        target = {
          "src/%1.vue",
          "src/%1.ts",
        },
        context = "source",
      },

      {
        pattern = "src/(.*)/index%.ts$",
        target = "tests/%1.spec.ts",
        context = "test",
      },
      {
        pattern = "tests/(.*)%.spec%.ts$",
        target = "src/%1/index.ts",
        context = "source (index)",
      },
    },
  })

  _G.nxs.keybind_set("n", "<leader>O", "<cmd>Other<cr>", "Open Alternate File")
  _G.nxs.keybind_set(
    "n",
    "<leader>os",
    "<cmd>OtherSplit<cr>",
    "Open Alternate File Split"
  )
  _G.nxs.keybind_set(
    "n",
    "<leader>ov",
    "<cmd>OtherVSplit<cr>",
    "Open Alternate File VSplit"
  )
end)
