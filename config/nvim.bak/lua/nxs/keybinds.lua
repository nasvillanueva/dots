-- Keybindings

vim.keymap.set(
  "",
  "<leader>ve",
  ":edit $MYVIMRC<cr>",
  { desc = "Edit Neovim Config" }
)
vim.keymap.set(
  "",
  "<leader>vs",
  ":source $MYVIMRC<cr>",
  { desc = "Reload Neovim Config" }
)
vim.keymap.set("n", "<leader>w", ":w!<cr>", { desc = "Quick Save" })

-- Sudo save
-- vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %') -- fix sudo issue

vim.keymap.set("", "<C-j>", "<C-W>j", { desc = "Switch to Bottom Window" })
vim.keymap.set("", "<C-k>", "<C-W>k", { desc = "Switch to Top Window" })
vim.keymap.set("", "<C-h>", "<C-W>h", { desc = "Switch to Left Window" })
vim.keymap.set("", "<C-l>", "<C-W>l", { desc = "Switch to Right Window" })

vim.keymap.set(
  "n",
  "<leader><Tab>",
  ":bnext<cr>",
  { desc = "Switch to Next Buffer" }
)
vim.keymap.set(
  "n",
  "<leader><S-Tab>",
  ":bprevious<cr>",
  { desc = "Switch to Previous Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>q",
  ":close<CR>",
  { desc = "Close Current Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>Q",
  ":bdelete<CR>",
  { desc = "Delete Current Buffer" }
)
vim.keymap.set(
  "n",
  "<leader><leader>q",
  ":bdelete!<CR>",
  { desc = "Force Close Current Buffer" }
)

vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Inverse Indention" })

vim.keymap.set("n", "<leader>/", ":nohl<CR>", { desc = "Dehighlight Results" })

vim.keymap.set(
  "c",
  "W",
  "w",
  { desc = "Alternative `save` because I always fat finger :W" }
)

vim.keymap.set("n", "[[", "<C-o>", { desc = "Goto Previous Cursor Position" })
vim.keymap.set("n", "]]", "<C-i>", { desc = "Goto Next Cursor Position" })

vim.keymap.set(
  "n",
  "<C-d>",
  "<C-d>zz",
  { desc = "Scroll down and center cursor" }
)
vim.keymap.set(
  "n",
  "<C-u>",
  "<C-u>zz",
  { desc = "Scroll up and center cursor" }
)

vim.keymap.set(
  "n",
  "n",
  "nzzzv",
  { desc = "Move to next search result and center cursor" }
)
vim.keymap.set(
  "n",
  "N",
  "Nzzzv",
  { desc = "Move to next search result and center cursor" }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines down" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable macro recording" })
