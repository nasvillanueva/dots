local M = {}

local EVENT_NAME = "NxsLazyLoad"

local module_loaders = {}

M.init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = EVENT_NAME,
    callback = function()
      for _, load in pairs(module_loaders) do
        load()
      end
    end,
  })
end

M.add = function(loader)
  table.insert(module_loaders, loader)
end

M.load = function()
  vim.schedule(function()
    vim.api.nvim_exec_autocmds(
      "User",
      { pattern = EVENT_NAME, modeline = false }
    )
  end)
end

return M
