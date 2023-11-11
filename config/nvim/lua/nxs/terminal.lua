local TERM_PATTERNS = { "term://*" }

vim.keymap.set("n", "<C-Space>", ":term<CR>", { desc = "Open terminal" })
vim.keymap.set(
  "t",
  "<C-\\><C-\\>",
  "<C-\\><C-n>",
  { desc = "Alternative Terminal Exit" }
)

vim.api.nvim_create_autocmd("TermOpen", {
  group = "nxs",
  pattern = TERM_PATTERNS,
  callback = function()
    vim.wo.number = false
    vim.wo.wrap = true
    vim.wo.spell = false
    vim.cmd("startinsert")
  end,
})
