local keybind = require("nxs.utils.keybind")

keybind.set("", "<leader>ve", ":edit $MYVIMRC<CR>", "Edit Neovim Config")
keybind.set("", "<leader>vs", ":source $MYVIMRC<CR>", "Reload Neovim Config")
keybind.set("n", "<leader>w", ":w!<CR>", "Quick Save")

keybind.set("n", "<leader><Tab>", ":bnext<CR>", "Switch to next buffer")
keybind.set("n", "<leader><S-Tab>", ":bprev<CR>", "Switch to previous buffer")

keybind.set("n", "<leader><leader>", ":nohl<CR>", "Clear search highlights")

keybind.set("n", "<C-d>", "<C-d>zz", "Scroll down and center cursor")
keybind.set("n", "<C-u>", "<C-u>zz", "Scroll up and center cursor")

keybind.set("n", "n", "nzzzv", "Move to next search result and center cursor")
keybind.set("n", "N", "Nzzzv", "Move to previous search result and center cursor")

keybind.set("v", "J", ":m '>+1<CR>gv=gv", "Move lines up")
keybind.set("v", "K", ":m '<-2<CR>gv=gv", "Move lines down")

keybind.set("n", "Q", "<NOP>", "Disable macro recording")
