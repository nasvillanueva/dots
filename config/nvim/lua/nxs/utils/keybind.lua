return {
  set = function(mode, keybind, cmd, desc, opts)
    vim.keymap.set(
      mode,
      keybind,
      cmd,
      vim.tbl_deep_extend("force", {
        desc = desc,
        noremap = true,
        silent = true,
      }, opts or {})
    )
  end,
}
