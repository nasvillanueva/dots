local constants = require("nxs.constants")

local augroup = function(name)
  return vim.api.nvim_create_augroup("nxs_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("eslint_format_on_save"),
  pattern = constants.js_files,
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

-- Restore last cursor position
-- https://github.com/neovim/neovim/issues/16339
vim.api.nvim_create_autocmd("BufRead", {
  group = augroup("last_cursor"),
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("WinResized", {
  group = augroup("smart_scrolloff"),
  callback = function()
    local scrolloff_percentage = 0.2
    vim.opt.scrolloff = math.floor(vim.o.lines * scrolloff_percentage)
  end,
})
