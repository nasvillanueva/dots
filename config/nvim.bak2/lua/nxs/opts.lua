-- Searching
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = false -- strict case-insensitive search even with upper ccase
vim.opt.magic = true -- basically regex syntax for searching
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- highlight matches while searching

-- Spaces / Wrapping
vim.opt.expandtab = true -- tabs into spaces
vim.opt.shiftwidth = 0 -- autoindent size; 0 to use tabstop value
vim.opt.tabstop = 2 -- tab size in spaces
vim.opt.softtabstop = 2 -- tab size while editing
vim.opt.wrap = false -- don't wrap
vim.opt.shiftround = true -- round indent to multiple of 'shiftwidth'

-- Interface
vim.opt.laststatus = 3 -- Only active window has statusline
vim.opt.listchars:append({ -- visualize whitespace
  lead = "·",
  trail = "·",
  nbsp = "·",
})
vim.opt.list = true
vim.opt.fillchars:append({ -- characters to fill interface
  eob = " ",
})
vim.opt.matchpairs:append({ -- characters that are treated as pairs; gets highlighted together
  "<:>",
})
vim.opt.showmatch = true -- highlights matching character/pair
vim.opt.matchtime = 2 -- tenths of a second to highlight the matching character/pair
vim.opt.number = true -- shows line numbers; with relativenumber, only shows current line number
vim.opt.relativenumber = true -- shows relative number
vim.opt.numberwidth = 4 -- line number column width
vim.opt.showmode = false -- displays mode; not needed with a statusline plugin
vim.opt.signcolumn = "yes" -- displays sign column
vim.opt.splitbelow = true -- default horizontal split to bottom
vim.opt.splitright = true -- default vertical split to right
vim.opt.startofline = false -- prevent some commands to move cursor at the start of line
vim.opt.cursorline = true -- highlight current line
vim.opt.cursorlineopt = "screenline" -- highlight both number and the text line
vim.opt.title = false -- don't set window title
vim.opt.visualbell = false -- disable visual bells
vim.opt.colorcolumn = "80" -- shows colored column at 80th character
vim.opt.errorbells = false -- disable error bells

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- sync clipboard with system clipboard, at least on macos

-- Files
vim.opt.hidden = true -- Abandons changes in hidden buffers
vim.opt.autochdir = false -- Prevent autochange directory
vim.opt.confirm = true -- enable confirmation for some operations
vim.opt.autowrite = false -- disables autosaving
vim.opt.backup = false -- disables creating a backup for overwritten files
vim.opt.undofile = true -- persist undos in a file
vim.opt.swapfile = false -- disables swap file

-- Misc
vim.opt.spell = true -- enables spellcheck
vim.opt.spelllang = "en,cjk"
vim.opt.mouse = ""
