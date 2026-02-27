MiniDeps.later(function()
  require("mini.surround").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()
end)

MiniDeps.later(function()
  MiniDeps.add({ source = "bsuth/emacs-bindings.nvim" })

  vim.g.loaded_emacs_bindings = true

  local emacs = require("emacs-bindings")

  local mode = { "i", "c" }

  _G.nxs.keybind_set(mode, "<C-f>", "<Right>")
  _G.nxs.keybind_set(mode, "<A-b>", emacs.move_word_back)
  _G.nxs.keybind_set(mode, "<A-f>", emacs.move_word_forward)
  _G.nxs.keybind_set(mode, "<C-h>", emacs.delete_char_back)
  _G.nxs.keybind_set(mode, "<C-d>", emacs.delete_char_forward)
  _G.nxs.keybind_set(mode, "<A-backspace>", emacs.delete_word_back)
  _G.nxs.keybind_set({ "i", "c", "t" }, "<A-d>", emacs.delete_word_forward)
  _G.nxs.keybind_set(mode, "<C-u>", emacs.delete_line_back)
  _G.nxs.keybind_set(mode, "<C-k>", emacs.delete_line_forward)
end)

MiniDeps.later(function()
  MiniDeps.add({
    source = "gregorias/coerce.nvim",
    depends = { "gregorias/coop.nvim" },
  })

  require("coerce").setup()
end)

MiniDeps.later(function()
  MiniDeps.add({ source = "keaising/im-select.nvim" })

  require("im_select").setup({
    default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
    set_previous_events = {},
    async_switch_im = false,
    default_command = { "macism" },
  })
end)
