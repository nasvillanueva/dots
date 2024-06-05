local keybind = require("nxs.utils.keybind")

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      require("copilot").setup({
        panel = { enabled = false },
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
      })

      keybind.set("", "<C-p>", function()
        require("copilot.suggestion").toggle_auto_trigger()
        vim.notify(
          "copilot enabled: "
            .. (vim.b.copilot_suggestion_auto_trigger and "yes" or "no")
        )
      end, "Copilot: Toggle suggestions")
    end,
  },
}
