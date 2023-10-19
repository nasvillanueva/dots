-- Settings

-- Core
vim.g.mapleader = ' '
vim.api.nvim_create_augroup('nxs', {})
vim.opt.exrc = false

-- Searching/Autocomplete
vim.opt.completeopt = 'menu,preview,longest'
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true

-- Spaces/Wrapping
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.shiftround = true

-- Interface
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.matchtime = 2
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.vb = false
vim.opt.colorcolumn = '80'

-- Performance
vim.g.matchparen_timeout = 10
vim.opt.scrollback = 100000
vim.opt.synmaxcol = 300
vim.opt.updatetime = 300
vim.opt.lazyredraw = true

-- History
vim.opt.clipboard = 'unnamedplus'

-- Files
vim.opt.hidden = true
vim.opt.autochdir = false
vim.opt.confirm = true
vim.opt.autowrite = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undo/'
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.undoreload = 10000
vim.opt.directory = os.getenv('HOME') .. '/.local/share/nvim/swap/'
vim.opt.swapfile = true
vim.opt.updatecount = 50

-- Misc
vim.opt.commentstring = '// %s'

-- Keybindings

vim.keymap.set('', '<leader>ve', ':edit $MYVIMRC<cr>', { desc = "Edit Neovim Config" })
vim.keymap.set('', '<leader>vs', ':source $MYVIMRC<cr>', { desc = "Reload Neovim Config" })
vim.keymap.set('n', '<leader>w', ':w!<cr>', { desc = "Quick Save" })

-- Sudo save
-- vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %') -- fix sudo issue

vim.keymap.set('', '<C-j>', '<C-W>j', { desc = "Switch to Bottom Window" })
vim.keymap.set('', '<C-k>', '<C-W>k', { desc = "Switch to Top Window" })
vim.keymap.set('', '<C-h>', '<C-W>h', { desc = "Switch to Left Window" })
vim.keymap.set('', '<C-l>', '<C-W>l', { desc = "Switch to Right Window" })

vim.keymap.set('n', '<leader><Tab>', ':bnext<cr>', { desc = "Switch to Next Buffer" })
vim.keymap.set('n', '<leader><S-Tab>', ':bprevious<cr>', { desc = "Switch to Previous Buffer" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Close Current Buffer" })
vim.keymap.set("n", "<leader><leader>q", ":bdelete!<CR>", { desc = "Force Close Current Buffer" })

vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Inverse Indention" })

vim.keymap.set("n", "<leader>/", ":nohl<CR>", { desc = "Dehighlight Results" })

vim.keymap.set("", "U", "<C-r>", { desc = "Redo" })

-- Plugins

if not package.loaded.lazy then
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    spec = {
      { import = 'nxs.plugins' }
    },
    install = {
      missing = true,
      colorscheme = { "synthwave84" },
    },
  })
end

require("nxs.terminal")
