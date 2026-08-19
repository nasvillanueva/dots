vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "avante.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    end
  end,
})

local setup_deferred = _G.nxs.deferred_packadd({
  {
    src = _G.nxs.gh("yetone/avante.nvim"),
    version = "main",
  },

  _G.nxs.gh("MunifTanjim/nui.nvim"),
  _G.nxs.gh("zbirenbaum/copilot.lua"),
  _G.nxs.gh("noisesfromspace/touchup.nvim"),
})

setup_deferred(function()
  require("avante").setup({
    provider = "copilot",
    behaviour = {
      auto_suggestions = false,
    },
  })

  -- ==================================================================== render-markdown
  require("touchup").setup({
    file_types = { "markdown", "Avante" },
  })
end)
