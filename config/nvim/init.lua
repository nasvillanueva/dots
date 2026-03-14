local nxs = {}

-- Define custom autocmd group
local autocmd_group = vim.api.nvim_create_augroup("nxs", { clear = true })
nxs.new_autocmd = function(event, pattern, callback, desc, once)
  vim.api.nvim_create_autocmd(event, {
    group = autocmd_group,
    pattern = pattern,
    callback = callback,
    desc = desc,
    once = once or false,
  })
end

nxs.keybind_set = function(mode, keybind, cmd, desc, opts)
  vim.keymap.set(
    mode,
    keybind,
    cmd,
    vim.tbl_deep_extend("force", {
      desc = desc,
      noremap = true,
      silent = true,
    }, opts or {})
  )
end

nxs.deferred_packadd = function(specs, opts)
  local deferred_spec_names = {}

  vim.pack.add(
    specs,
    vim.tbl_deep_extend("force", {
      load = function(plug_data)
        table.insert(deferred_spec_names, plug_data.spec.name)
      end,
    }, opts or {})
  )

  return function(setup)
    vim.schedule(function()
      for _, deferred_spec_name in ipairs(deferred_spec_names) do
        vim.cmd.packadd(deferred_spec_name)
      end

      setup()
    end)
  end
end

nxs.gh = function(x)
  return "https://github.com/" .. x
end

_G.nxs = nxs
