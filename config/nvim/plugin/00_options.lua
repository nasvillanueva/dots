vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Eagerly disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- UI ========================================================================
vim.opt.breakindent = true -- Indent wrapped lines to match line start
vim.opt.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
vim.opt.colorcolumn = "+1" -- Draw column on the right of maximum width
vim.opt.cursorline = true -- Enable current line highlighting
vim.opt.cursorlineopt = "screenline,number" -- highlight both number and the text line
vim.opt.errorbells = false -- disable error bells
vim.opt.laststatus = 3 -- Single status line
vim.opt.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.opt.list = true -- Show helpful text indicators
vim.opt.matchtime = 2 -- tenths of a second to highlight the matching character/pair
vim.opt.number = true -- Show line numbers
vim.opt.numberwidth = 4 -- line number column width
vim.opt.pumheight = 10 -- Make popup menu smaller
vim.opt.ruler = false -- Don't show cursor coordinates
vim.opt.shortmess = "CFOSWaco" -- Disable some built-in completion messages
vim.opt.showmatch = true -- highlights matching character/pair
vim.opt.showmode = false -- displays mode; not needed with a statusline plugin
vim.opt.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.opt.splitbelow = true -- Horizontal splits will be below
vim.opt.splitkeep = "screen" -- Reduce scroll during window split
vim.opt.splitright = true -- Vertical splits will be to the right
vim.opt.startofline = false -- prevent some commands to move cursor at the start of line
vim.opt.title = false -- don't set window title
vim.opt.visualbell = false -- disable visual bells
vim.opt.winborder = "solid" -- Use border in floating windows
vim.opt.wrap = false -- Don't visually wrap lines (toggle with \w)

-- Special UI symbols
vim.opt.fillchars:append({ -- characters to fill interface
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  eob = " ",
})
vim.opt.listchars:append({ -- visualize whitespace
  lead = "·",
  trail = "·",
  nbsp = "·",
})

vim.opt.matchpairs:append({ -- characters that are treated as pairs; gets highlighted together
  "<:>",
})

-- Folding
vim.opt.foldlevel = 1 -- Fold everything except top level
vim.opt.foldmethod = "indent" -- Fold based on indent level
vim.opt.foldnestmax = 10 -- Limit number of fold levels
vim.opt.foldtext = "" -- Show text under fold with its highlighting

-- Editing ====================================================================
vim.opt.autoindent = true -- Use auto indent
vim.opt.clipboard = "unnamedplus" -- sync clipboard with system clipboard, at least on macos
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.formatoptions = "jcroqlnt1" -- Improve comment editing
vim.opt.hlsearch = true -- highlight search matches
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.infercase = true -- Infer case in built-in completion
vim.opt.magic = true -- basically regex syntax for searching
vim.opt.shiftround = true -- round indent to multiple of 'shiftwidth'
vim.opt.shiftwidth = 0 -- autoindent size; 0 to use tabstop value
vim.opt.smartcase = true -- Respect case if search pattern has upper case
vim.opt.smartindent = true -- Make indenting smart
vim.opt.softtabstop = 2 -- tab size while editing
vim.opt.spell = true -- enables spellcheck
vim.opt.spelllang = "en,cjk"
vim.opt.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.opt.tabstop = 2 -- Show tab as this number of spaces
vim.opt.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.opt.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part

-- Pattern for a start of 'numbered' list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menu,menuone,noselect,fuzzy,nosort,popup"

-- Files
vim.opt.autochdir = false -- Prevent autochange directory
vim.opt.autowrite = false -- disables autosaving
vim.opt.backup = false -- disables creating a backup for overwritten files
vim.opt.confirm = true -- enable confirmation for some operations
vim.opt.hidden = true -- Abandons changes in hidden buffers
vim.opt.swapfile = false -- disables swap file
vim.opt.undofile = true -- persist undos in a file

-- Misc
vim.opt.mouse = ""

_G.nxs.diagnostic_base_options = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

  -- Show all diagnostics as underline (for their meessages type `<Leader>ld`)
  underline = { severity = { min = "HINT", max = "ERROR" } },

  -- Show more details immediately only for errors at current line end
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
MiniDeps.later(function()
  vim.diagnostic.config(_G.nxs.diagnostic_base_options)
end)
