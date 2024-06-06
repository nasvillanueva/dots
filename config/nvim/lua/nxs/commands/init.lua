vim.api.nvim_create_user_command("CleanBuffers", function()
  for _, bufinfo in ipairs(vim.fn.getbufinfo()) do
    if bufinfo.listed == 1 and #bufinfo.windows == 0 then
      vim.api.nvim_buf_delete(bufinfo.bufnr, {})
    end
  end
end, {})
