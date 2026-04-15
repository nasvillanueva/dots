local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("zbirenbaum/copilot.lua"),
  {
    src = _G.nxs.gh("olimorris/codecompanion.nvim"),
    version = vim.version.range("^19.0.0"),
  },
  _G.nxs.gh("MeanderingProgrammer/render-markdown.nvim"),
})

setup_deferred(function()
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })

  require("codecompanion").setup({
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "copilot",
    },
    background = {
      adapter = "copilot",
    },
  })

  _G.nxs.keybind_set("n", "<leader>ait", "<cmd>CodeCompanionChat Toggle<cr>")
  _G.nxs.keybind_set({ "n", "v" }, "<leader>aic", "<cmd>CodeCompanion<cr>")
  _G.nxs.keybind_set(
    { "n", "v" },
    "<leader>aig",
    "<cmd>CodeCompanionActions<cr>"
  )

  -- ==================================================================== render-markdown
  require("render-markdown").setup({
    file_types = { "codecompanion" },
  })
end)
