-- Searching/Autocomplete
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

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
vim.opt.listchars:append({
  lead = "·",
  trail = "·",
  nbsp = "·",
})
vim.opt.list = true
vim.opt.fillchars = "eob: "
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.matchtime = 2
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false
vim.opt.cursorline = true
vim.opt.title = true
vim.opt.vb = false
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true

-- Performance
vim.g.matchparen_timeout = 10
vim.opt.scrollback = 100000
vim.opt.synmaxcol = 300
vim.opt.updatetime = 50
vim.opt.lazyredraw = false

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Files
vim.opt.hidden = true
vim.opt.autochdir = false
vim.opt.confirm = true
vim.opt.autowrite = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo/"
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.undoreload = 10000
vim.opt.swapfile = false
vim.opt.updatecount = 50

-- Misc
vim.opt.commentstring = "// %s"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.mouse = ""
