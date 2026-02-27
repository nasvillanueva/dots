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

local copy_path = function(relative, prefix)
  local path = get_path()

  if relative then
    path = vim.fn.fnamemodify(path, ":.")
  end

  if prefix ~= nil then
    path = path:gsub(prefix, "")
  end

  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end

vim.api.nvim_create_user_command("CopyFilePath", function(opts)
  local args = opts.fargs

  local relative = false
  local prefix = nil

  for _, arg in ipairs(args) do
    if arg == "relative" then
      relative = true
    elseif vim.startswith(arg, "prefix=") then
      prefix = arg:sub(#"prefix=" + 1)
    end
  end

  copy_path(relative, prefix)
end, {
  nargs = "*",
  complete = function(arglead)
    local candidates = {
      "relative",
      "prefix=",
    }

    return vim.tbl_filter(function(c)
      return vim.startswith(c, arglead)
    end, candidates)
  end,
})
