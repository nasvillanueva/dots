local keybind = require("nxs.utils.keybind")

keybind.set("", "<leader>w", ":write <CR>")
keybind.set("", "<leader>W", ":wall <CR>")
keybind.set("", "<leader>ve", ":edit $MYVIMRC<CR>", "Edit Neovim Config")
keybind.set("", "<leader>vs", ":source $MYVIMRC<CR>", "Reload Neovim Config")

keybind.set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
keybind.set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  "Better Down",
  { expr = true }
)
keybind.set(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)
keybind.set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  "Better Up",
  { expr = true }
)

keybind.set("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height")
keybind.set("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height")
keybind.set(
  "n",
  "<C-Left>",
  "<cmd>vertical resize -2<cr>",
  "Decrease Window Width"
)
keybind.set(
  "n",
  "<C-Right>",
  "<cmd>vertical resize +2<cr>",
  "Increase Window Width"
)

keybind.set("n", "<C-d>", "<C-d>zz", "Scroll down and center cursor")
keybind.set("n", "<C-u>", "<C-u>zz", "Scroll up and center cursor")
keybind.set("n", "<PageDown>", "<C-d>", "Scroll down and center cursor")
keybind.set("n", "<PageUp>", "<C-u>", "Scroll up and center cursor")
keybind.set("i", "<PageDown>", "<C-o><C-d>", "Scroll down and center cursor")
keybind.set("i", "<PageUp>", "<C-o><C-u>", "Scroll up and center cursor")

keybind.set("n", "n", "nzzzv", "Move to next search result and center cursor")
keybind.set(
  "n",
  "N",
  "Nzzzv",
  "Move to previous search result and center cursor"
)

keybind.set(
  "n",
  "<A-j>",
  "<cmd>execute 'move .+' . v:count1<cr>==",
  "Move Down"
)
keybind.set(
  "n",
  "<A-k>",
  "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  "Move Up"
)
keybind.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move Down")
keybind.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move Up")
keybind.set(
  "v",
  "<A-j>",
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  "Move Down"
)
keybind.set(
  "v",
  "<A-k>",
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  "Move Up"
)

keybind.set("n", "[b", "<cmd>bprevious<cr>", "Prev buffer")
keybind.set("n", "]b", "<cmd>bnext<cr>", "Next buffer")

keybind.set(
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

keybind.set("v", "<", "<gv", "Indent Left")
keybind.set("v", ">", ">gv", "Indent Right")

keybind.set("n", "<leader>xl", "<cmd>lopen<cr>", "Location List")
keybind.set("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix List")

keybind.set("n", "[q", vim.cmd.cprev, "Previous quickfix")
keybind.set("n", "]q", vim.cmd.cnext, "Next quickfix")

local open_diagnostic_virtual_line = function()
  vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup(
      "nxs-line-diagnostic",
      { clear = true }
    ),
    once = true,
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
    end,
  })
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

keybind.set(
  "n",
  "<leader>d",
  open_diagnostic_virtual_line,
  "View Line Diagnostics"
)
keybind.set("n", "]d", diagnostic_goto(true), "Next Diagnostic")
keybind.set("n", "[d", diagnostic_goto(false), "Prev Diagnostic")
keybind.set("n", "]e", diagnostic_goto(true, "ERROR"), "Next Error")
keybind.set("n", "[e", diagnostic_goto(false, "ERROR"), "Prev Error")
keybind.set("n", "]w", diagnostic_goto(true, "WARN"), "Next Warning")
keybind.set("n", "[w", diagnostic_goto(false, "WARN"), "Prev Warning")

keybind.set("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
keybind.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
keybind.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
keybind.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
keybind.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
keybind.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "Previous Tab")

keybind.set(
  "n",
  "<leader>fy",
  "<cmd>CopyRelativeFilePath<CR>",
  "Copy Relative File Path"
)
keybind.set(
  "n",
  "<leader>fY",
  "<cmd>CopyAbsoluteFilePath<CR>",
  "Copy Absolute File Path"
)
