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

  _G.nxs.gh("HakonHarnes/img-clip.nvim"),
  _G.nxs.gh("MunifTanjim/nui.nvim"),
  _G.nxs.gh("zbirenbaum/copilot.lua"),
  _G.nxs.gh("MeanderingProgrammer/render-markdown.nvim"),
})

setup_deferred(function()
  require("avante").setup({
    provider = "copilot",
    behaviour = {
      auto_suggestions = false,
    },
  })

  -- ==================================================================== img-clip
  require("img-clip").setup({
    -- recommended settings
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
  })
  -- ==================================================================== render-markdown
  require("render-markdown").setup({
    file_types = { "markdown", "Avante" },
  })
end)
