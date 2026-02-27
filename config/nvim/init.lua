local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup()

-- Initialize personal namespace in the global object.
_G.nxs = {}

-- Define custom autocmd group
local autocmd_group = vim.api.nvim_create_augroup("nxs", { clear = true })
_G.nxs.new_autocmd = function(event, pattern, callback, desc, once)
  vim.api.nvim_create_autocmd(event, {
    group = autocmd_group,
    pattern = pattern,
    callback = callback,
    desc = desc,
    once = once or false,
  })
end

_G.nxs.keybind_set = function(mode, keybind, cmd, desc, opts)
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
end
