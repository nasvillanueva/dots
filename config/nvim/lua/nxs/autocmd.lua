local augroup = function(name)
  return vim.api.nvim_create_augroup("nxs_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("eslint_format_on_save"),
  pattern = { "*.js", "*.cjs", "*.mjs", "*.jsx", "*.ts", "*.tsx", "*.vue" },
  callback = function()
    if vim.fn.exists(":EslintFixAll") ~= 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_cursor"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if
      vim.tbl_contains(exclude, vim.bo[buf].filetype)
      or vim.b[buf].nxs_last_cursor
    then
      return
    end
    vim.b[buf].nxs_last_cursor = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("WinResized", {
  group = augroup("smart_scrolloff"),
  callback = function()
    local scrolloff_percentage = 0.2
    vim.opt.scrolloff = math.floor(vim.o.lines * scrolloff_percentage)
  end,
})
