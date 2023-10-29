local TERM_PATTERNS = { "term://*" }

vim.keymap.set("n", "<C-Space>", ":term<CR>", { desc = "Open terminal" })
vim.keymap.set(
  "t",
  "<C-\\><C-\\>",
  "<C-\\><C-n>:bdelete!<CR>",
  { desc = "Exit terminal" }
)

vim.api.nvim_create_autocmd("TermOpen", {
  group = "nxs",
  pattern = TERM_PATTERNS,
  callback = function()
    vim.wo.number = false
    vim.wo.wrap = true
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = "nxs",
  pattern = TERM_PATTERNS,
  callback = function()
    if vim.g.lazygit_opened == 1 then
      return
    end

    vim.defer_fn(function()
      vim.cmd("Oil")
    end, 0)
  end,
})
