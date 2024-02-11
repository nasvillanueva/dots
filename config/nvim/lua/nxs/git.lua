require("gitsigns").setup({})
require("diffview").setup({}) -- required by neogit
require("neogit").setup({
  integrations = {
    telescope = true,
    diffview = true,
  }
})

