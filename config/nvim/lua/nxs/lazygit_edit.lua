-- TODO: Figure out why line number is not working when opening in
-- NVIM > LAZYGIT, but works with LAZYGIT alone
return function(filename, line_number)
  line_number = tonumber(line_number) or 1

  vim.api.nvim_win_close(0, true)
  vim.cmd("edit +" .. line_number .. " " .. filename)
end
