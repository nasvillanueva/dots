local keybind = require("nxs.utils.keybind")

-- System Dependencies
-- - ripgrep
-- - fd

-- Autoloded dependencies
-- plenary
-- telescope-fzf-native
-- nvim-web-devicons

-- After updating, be sure to run make for telescope-fzf-native
-- TODO: Automate it

local telescope = require("telescope")

telescope.setup({
  defaults = require("telescope.themes").get_ivy({
    layout_strategy = "bottom_pane",
    prompt_position = "bottom",
    sorting_strategy = "descending",
    border = false,
    prompt_prefix = '➜ ',
    selection_caret = '  ',
  }),
  extensions = {
    fzf = {
      fuzzy = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
})

telescope.load_extension("fzf")

-- TODO: Move this to utils? I have to remove usage of telescope.utils though
local function is_git_project()
  local _, ret, _ = require("telescope.utils").get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  return ret == 0
end

if is_git_project() then
  keybind.set("n", "<leader>O", ":Telescope find_files<CR>", "Telescope: Find Files")
else
  keybind.set("n", "<leader>O", ":Telescope git_files<CR>", "Telescope: Git Files")
end

keybind.set("n", "<leader>e", ":Telescope oldfiles<CR>", "Telescope: Recent Files")
