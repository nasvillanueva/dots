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

-- vim.opt.colorcolumn = '80' -- use smartcolumn.nvim instead
vim.cmd('highlight SignColumn guibg=bg')
vim.cmd('highlight ColorColumn guibg=darkcyan')

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

-- Edit config file
vim.keymap.set('', '<leader>ve', ':edit $MYVIMRC<cr>', { noremap = true })

-- Reload config file
vim.keymap.set('', '<leader>vs', ':source $MYVIMRC<cr>', { noremap = true })

-- Yank to system clipboard
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- Highlight last inserted text
vim.keymap.set('n', 'gV', "'[V']", { noremap = true })

-- Quick save
vim.keymap.set('n', '<leader>w', ':w!<cr>')

-- Sudo save
-- vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %') -- fix sudo issue

-- Smart way to move between windows
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Buffers, preferred over tabs now with bufferline.
vim.keymap.set('n', '<leader><Tab>', ':bnext<cr>')
vim.keymap.set('n', '<leader><S-Tab>', ':bprevious<cr>')
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Cloes Current Buffer" })

-- Shift-Tab to inverse indent
vim.keymap.set("i", "<S-Tab>", "<C-d>")

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
      colorscheme = {}, -- prevent lazy.nvim from overriding term colors
    },
  })
end
