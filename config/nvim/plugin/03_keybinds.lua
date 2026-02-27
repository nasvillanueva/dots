_G.nxs.keybind_set("n", "<C-Space>", ":sp|term<CR>", "Open terminal")
_G.nxs.keybind_set(
  "t",
  "<C-\\><C-\\>",
  "<C-\\><C-n>",
  "Alternative Terminal Exit"
)

_G.nxs.keybind_set("", "<leader>w", ":write <CR>")
_G.nxs.keybind_set("", "<leader>W", ":wall <CR>")
_G.nxs.keybind_set("", "<leader>ve", ":edit $MYVIMRC<CR>", "Edit Neovim Config")
_G.nxs.keybind_set(
  "",
  "<leader>vs",
  ":source $MYVIMRC<CR>",
  "Reload Neovim Config"
)

_G.nxs.keybind_set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
_G.nxs.keybind_set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
_G.nxs.keybind_set(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)
_G.nxs.keybind_set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)

_G.nxs.keybind_set(
  "n",
  "<C-Up>",
  "<cmd>resize +2<cr>",
  "Increase Window Height"
)
_G.nxs.keybind_set(
  "n",
  "<C-Down>",
  "<cmd>resize -2<cr>",
  "Decrease Window Height"
)
_G.nxs.keybind_set(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<cr>",
  "Decrease Window Width"
)
_G.nxs.keybind_set(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<cr>",
  "Increase Window Width"
)

_G.nxs.keybind_set("n", "<C-d>", "<C-d>zz", "Scroll down and center cursor")
_G.nxs.keybind_set("n", "<C-u>", "<C-u>zz", "Scroll up and center cursor")
_G.nxs.keybind_set("n", "<PageDown>", "<C-d>", "Scroll down and center cursor")
_G.nxs.keybind_set("n", "<PageUp>", "<C-u>", "Scroll up and center cursor")
_G.nxs.keybind_set(
  "i",
  "<PageDown>",
  "<C-o><C-d>",
  "Scroll down and center cursor"
)
_G.nxs.keybind_set("i", "<PageUp>", "<C-o><C-u>", "Scroll up and center cursor")

_G.nxs.keybind_set(
  "n",
  "n",
  "nzzzv",
  "Move to next search result and center cursor"
)
_G.nxs.keybind_set(
  "n",
  "N",
  "Nzzzv",
  "Move to previous search result and center cursor"
)

_G.nxs.keybind_set(
  "n",
  "<A-j>",
  "<cmd>execute 'move .+' . v:count1<cr>==",
  "Move Down"
)
_G.nxs.keybind_set(
  "n",
  "<A-k>",
  "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  "Move Up"
)
_G.nxs.keybind_set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move Down")
_G.nxs.keybind_set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move Up")
_G.nxs.keybind_set(
  "v",
  "<A-j>",
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  "Move Down"
)
_G.nxs.keybind_set(
  "v",
  "<A-k>",
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  "Move Up"
)

_G.nxs.keybind_set("n", "[b", "<cmd>bprevious<cr>", "Prev buffer")
_G.nxs.keybind_set("n", "]b", "<cmd>bnext<cr>", "Next buffer")

_G.nxs.keybind_set(
  { "i", "n" },
  "<esc>",
  function()
    vim.cmd("noh")
    vim.snippet.stop()
    return "<esc>"
  end,
  "Escape and clear hlsearch",
  {
    expr = true,
  }
)

_G.nxs.keybind_set("v", "<", "<gv", "Indent Left")
_G.nxs.keybind_set("v", ">", ">gv", "Indent Right")

_G.nxs.keybind_set("n", "<leader>xl", "<cmd>lopen<cr>", "Location List")
_G.nxs.keybind_set("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix List")

_G.nxs.keybind_set("n", "[q", vim.cmd.cprev, "Previous quickfix")
_G.nxs.keybind_set("n", "]q", vim.cmd.cnext, "Next quickfix")

local open_diagnostic_virtual_line = function()
  vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
  })
  _G.nxs.new_autocmd("CursorMoved", "*", function()
    vim.diagnostic.config(_G.nxs.diagnostic_base_options)
  end, "Reset diagnostic config", true)
end

local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = next and 1 or -1, severity = severity })
    vim.schedule(function()
      open_diagnostic_virtual_line()
    end)
  end
end

_G.nxs.keybind_set(
  "n",
  "<leader>d",
  open_diagnostic_virtual_line,
  "View Line Diagnostics"
)
_G.nxs.keybind_set("n", "]d", diagnostic_goto(true), "Next Diagnostic")
_G.nxs.keybind_set("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
_G.nxs.keybind_set("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
_G.nxs.keybind_set("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
_G.nxs.keybind_set("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
_G.nxs.keybind_set("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")

_G.nxs.keybind_set("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
_G.nxs.keybind_set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
_G.nxs.keybind_set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
_G.nxs.keybind_set("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
_G.nxs.keybind_set("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
_G.nxs.keybind_set(
  "n",
  "<leader><tab>[",
  "<cmd>tabprevious<cr>",
  "Previous Tab"
)

_G.nxs.keybind_set(
  "n",
  "<leader>yr",
  "<cmd>CopyFilePath relative<CR>",
  "Copy Relative File Path"
)
_G.nxs.keybind_set(
  "n",
  "<leader>ya",
  "<cmd>CopyFilePath<CR>",
  "Copy Absolute File Path"
)
_G.nxs.keybind_set(
  "n",
  "<leader>yt",
  "<cmd>CopyFilePath relative prefix=public/<CR>",
  "Copy Relative For Public Directory"
)
