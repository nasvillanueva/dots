local lazyload = require("nxs.utils.lazyload")
lazyload.init()

vim.g.mapleader = " "

require("nxs.colorscheme")

require("nxs.opts")
require("nxs.autocmd")
require("nxs.terminal")
require("nxs.keybinds")

-- Needed by many dependencies
require("nvim-web-devicons").setup({})

require("nxs.lualine")
require("nxs.explorer")
require("nxs.ime")
require("nxs.treesitter")
require("nxs.telescope") -- requires treesitter
require("nxs.git") -- requires git

require("nxs.whichkey")

require("nxs.lsp")

lazyload.load()
