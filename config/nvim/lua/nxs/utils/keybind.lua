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
  lazyKey = function(mode, keybind, cmd, desc, opts)
    return vim.tbl_deep_extend("force", {
      keybind,
      cmd,
      mode = mode,
      desc = desc,
      silent = true,
      noremap = true,
    }, opts or {})
  end,
}
