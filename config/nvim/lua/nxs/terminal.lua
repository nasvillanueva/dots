local TERM_PATTERNS = { "term://*" }

vim.keymap.set("n", "<C-Space>", ":term<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })

vim.api.nvim_create_autocmd("TermOpen", {
  group = "nxs",
  pattern = TERM_PATTERNS,
  callback = function()
    vim.wo.number = false
    vim.wo.wrap = true
    vim.cmd("startinsert")
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  group = "nxs",
  pattern = TERM_PATTERNS,
  callback = function()
    -- Returns the address of the last buffer
    local last = vim.fn.bufnr("$")
    -- Returns empty string if buffer doesn't exists
    local last_name = vim.fn.bufname(last)
    if last_name ~= "" then
      vim.cmd("buffer $")
    else
      vim.defer_fn(function()
        vim.cmd("Oil")
      end, 0)
    end
  end
})
