local REGISTERED_PLUGINS = {}

local PLUGINS_DIR = vim.fn.stdpath("data") .. "/nxs/plugins"

local function tbl_find(tbl, cb)
  for _, elem in ipairs(tbl) do
    if cb(elem) then
      return elem
    end
  end
  return nil
end

-- Add the plugin_path after ~/.config/nvim and before the first /after
local function add_to_rtp(plugin_path)
  local rtp = vim.api.nvim_get_runtime_file("", true)
  local plugin_insertion_index = 2 -- Skip ~/.config/nvim which has index of 1
  local plugin_after_insertion_index

  for i, path in ipairs(rtp) do
    if not plugin_after_insertion_index and path:sub(-6, -1) == "/after" then
      plugin_after_insertion_index = i + 1 -- +1 to offset the insertion of the plugin dir
      plugin_insertion_index = i
      break
    end
  end

  table.insert(rtp, plugin_insertion_index or (#rtp + 1), plugin_path)

  local after_path = plugin_path .. "/after"
  if vim.loop.fs_stat(after_path) then
    table.insert(rtp, plugin_after_insertion_index or (#rtp + 1), after_path)
  end

  vim.opt.rtp = rtp
end

if not vim.loop.fs_stat(PLUGINS_DIR) then
  vim.fn.system({ "mkdir", "-p", PLUGINS_DIR })
end

for _, plugin_dir in ipairs(vim.fn.readdir(PLUGINS_DIR)) do
  local plugin_path = PLUGINS_DIR .. "/" .. plugin_dir
  table.insert(REGISTERED_PLUGINS, {
    path = plugin_path,
    loaded = false,
    config = nil,
  })

  add_to_rtp(plugin_path)
end

local function use(plugin_name, config)
  local plugin_path = PLUGINS_DIR .. "/" .. vim.fs.basename(plugin_name)
  local plugin = tbl_find(REGISTERED_PLUGINS, function(registered_plugin)
    return registered_plugin.path == plugin_path
  end)

  if plugin ~= nil then
    plugin.loaded = true
    plugin.config = config
    return
  end

  local clone_cmd = "git clone --depth 1 https://github.com/"
    .. plugin_name
    .. ".git "
    .. plugin_path

  print(clone_cmd)
  print(vim.fn.system(clone_cmd))

  add_to_rtp(plugin_path)

  if config ~= nil and type(config.build) == "function" then
    local cwd = vim.fn.getcwd()
    vim.cmd("cd " .. plugin_path)
    config.build()
    vim.cmd("cd " .. cwd)
  end

  table.insert(REGISTERED_PLUGINS, {
    path = plugin_path,
    loaded = true,
    config = config,
  })
end

local function lazily_setup(setup)
  local nxs_group = vim.api.nvim_create_augroup("nxs", { clear = false })

  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      vim.schedule(function()
        setup()
      end)
    end,
    group = nxs_group,
  })
end


-- TODO
-- 1. Cleanup -- make sure RTP gets updated properly
-- 2. Update

return {
  use = use,
  lazily_setup = lazily_setup,
}
