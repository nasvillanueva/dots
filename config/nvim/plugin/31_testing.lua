local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("nvim-neotest/nvim-nio"),
  _G.nxs.gh("antoinemadec/FixCursorHold.nvim"),
  _G.nxs.gh("marilari88/neotest-vitest"),
  _G.nxs.gh("nvim-neotest/neotest"),
})

setup_deferred(function()
  local neotest = require("neotest")
  neotest.setup({
    adapters = {
      require("neotest-vitest")({
        vitestCommand = "npx vitest run",
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      }),
    },
  })

  _G.nxs.keybind_set("n", "<leader>ta", function()
    neotest.output_panel.clear()
    neotest.run.run()
  end, "Neotest Vitest: Run All Tests")

  _G.nxs.keybind_set("n", "<leader>tf", function()
    neotest.output_panel.clear()
    neotest.run.run({ vim.fn.expand("%") })
  end, "Neotest Vitest: Run File")

  _G.nxs.keybind_set(
    "n",
    "<leader>ts",
    "<cmd>Neotest summary<cr>",
    "Neotest: Open Summary"
  )

  _G.nxs.keybind_set(
    "n",
    "<leader>to",
    "<cmd>Neotest output<cr>",
    "Neotest: Open Output"
  )

  _G.nxs.keybind_set(
    "n",
    "<leader>tp",
    "<cmd>Neotest output-panel<cr>",
    "Neotest: Open Output Panel"
  )

  _G.nxs.keybind_set("n", "]t", "<CMD>Neotest jump next<CR>", "Next Test")
  _G.nxs.keybind_set("n", "[t", "<CMD>Neotest jump prev<CR>", "Next Test")
end)
