local scrolloff_percentage = 0.2

vim.api.nvim_create_autocmd({ "WinResized" }, {
  group = vim.api.nvim_create_augroup("smart-scrolloff", { clear = true }),
  callback = function()
    vim.opt.scrolloff = math.floor(vim.o.lines * scrolloff_percentage)
  end,
})
