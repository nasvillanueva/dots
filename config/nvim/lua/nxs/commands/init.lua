vim.api.nvim_create_user_command("CleanBuffers", function()
  for _, bufinfo in ipairs(vim.fn.getbufinfo()) do
    if bufinfo.listed == 1 and #bufinfo.windows == 0 then
      vim.api.nvim_buf_delete(bufinfo.bufnr, {})
    end
  end
end, {})

local get_path = function()
  local path = vim.fn.expand("%")

  if path:find("^oil://") ~= nil then
    return string.sub(path, 7)
  end

  return path
end

local copy_path = function(relative)
  return function()
    local path = get_path()

    if relative then
      path = vim.fn.fnamemodify(path, ":.")
    end
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end
end

vim.api.nvim_create_user_command("CopyAbsoluteFilePath", copy_path(false), {})
vim.api.nvim_create_user_command("CopyRelativeFilePath", copy_path(true), {})
