-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  print("lazy just installed, please restart neovim")
  return
end

lazy.setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
    require("nxs.plugins.colorscheme"),
    require("nxs.plugins.git"),
    require("nxs.plugins.whichkey"),
    require("nxs.plugins.files"),
    require("nxs.plugins.notes"),
    require("nxs.plugins.snacks"),
    require("nxs.plugins.ime"),
    require("nxs.plugins.lualine"),
    require("nxs.plugins.treesitter"),
    require("nxs.plugins.utilities"),
    require("nxs.plugins.trouble"),
    require("nxs.plugins.mason"),
    require("nxs.plugins.cmp"),
    require("nxs.plugins.lsp"),
    require("nxs.plugins.format"),
  },
  install = {
    missing = true,
    colorscheme = { "rose-pine" },
  },
})
