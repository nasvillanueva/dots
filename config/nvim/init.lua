vim.g.mapleader = " "

-- Eagerly disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nxs.opts")
require("nxs.keybinds")
require("nxs.autocmd")
require("nxs.terminal")
require("nxs.plugins")
require("nxs.commands")
