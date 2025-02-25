local keybind = require("nxs.utils.keybind")

keybind.set("n", "<C-Space>", ":sp|term<CR>", "Open terminal")
keybind.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", "Alternative Terminal Exit")

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.wrap = true
    vim.wo.spell = false
    vim.cmd("startinsert")
  end,
})
