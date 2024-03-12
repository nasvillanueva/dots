return {
  set = function(mode, keybind, cmd, desc)
    vim.keymap.set(
      mode,
      keybind,
      cmd,
      { desc = desc, noremap = true, silent = true }
    )
  end,
}
