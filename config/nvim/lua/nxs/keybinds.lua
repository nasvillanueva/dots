local keybind = require("nxs.utils.keybind")

keybind.set("", "<leader>ve", ":edit $MYVIMRC<CR>", "Edit Neovim Config")
keybind.set("", "<leader>vs", ":source $MYVIMRC<CR>", "Reload Neovim Config")
keybind.set("n", "q", "<NOP>", "Disable macro recording")

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

keybind.set("n", "<C-w><S-j>", "<cmd>resize +2<cr>", "Increase window height")
keybind.set("n", "<C-w><S-k>", "<cmd>resize -2<cr>", "Decrease window height")
keybind.set("n", "<C-w><S-h>", "<cmd>vertical resize -2<cr>", "Decrease window width")
keybind.set("n", "<C-w><S-l>", "<cmd>vertical resize +2<cr>", "Increase window width")

keybind.set("n", "<C-d>", "<C-d>zz", "Scroll down and center cursor")
keybind.set("n", "<C-u>", "<C-u>zz", "Scroll up and center cursor")

keybind.set("n", "n", "nzzzv", "Move to next search result and center cursor")
keybind.set(
  "n",
  "N",
  "Nzzzv",
  "Move to previous search result and center cursor"
)

keybind.set("n", "<A-j>", "<cmd>m .+1<cr>==", "Move current line down")
keybind.set("n", "<A-k>", "<cmd>m .-2<cr>==", "Move current line up")
keybind.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move current line down")
keybind.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move current line up")
keybind.set("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move current line down")
keybind.set("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move current line up")

keybind.set("n", "[b", "<cmd>bprevious<cr>", "Prev buffer")
keybind.set("n", "]b", "<cmd>bnext<cr>", "Next buffer")

keybind.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")

keybind.set("v", "<", "<gv", "Indent Left")
keybind.set("v", ">", ">gv", "Indent Right")

keybind.set("n", "<leader>xl", "<cmd>lopen<cr>", "Location List")
keybind.set("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix List")

keybind.set("n", "[q", vim.cmd.cprev, "Previous quickfix")
keybind.set("n", "]q", vim.cmd.cnext, "Next quickfix")

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
keybind.set("n", "<leader>cd", vim.diagnostic.open_float, "View Line Diagnostics")
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
