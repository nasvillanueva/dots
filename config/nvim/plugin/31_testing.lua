local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("nvim-neotest/nvim-nio"),
  _G.nxs.gh("antoinemadec/FixCursorHold.nvim"),
  _G.nxs.gh("marilari88/neotest-vitest"),
  _G.nxs.gh("nvim-neotest/neotest"),
})

setup_deferred(function()
  require("neotest").setup({
    adapters = {
      require("neotest-vitest")({
        vitestCommand = "npx vitest run",
        filter_dir = function(name)
          return name ~= "node_modules"
        end,
      }),
    },
  })

  _G.nxs.keybind_set(
    "n",
    "<leader>ta",
    "<cmd>lua require('neotest').run.run()<cr>",
    "Neotest Vitest: Run All Tests"
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tf",
    "<cmd>lua require('neotest').run.run({ vim.fn.expand('%') })<cr>",
    { desc = "Neotest Vitest: Run File" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>ts",
    "<cmd>Neotest summary<cr>",
    { desc = "Neotest: Open Summary" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>to",
    "<cmd>Neotest output<cr>",
    { desc = "Neotest: Open Output" }
  )

  vim.api.nvim_set_keymap(
    "n",
    "<leader>tp",
    "<cmd>Neotest output-panel<cr>",
    { desc = "Neotest: Open Output Panel" }
  )
end)
