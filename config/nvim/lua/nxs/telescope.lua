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
  extensions = {
    fzf = {
      fuzzy = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
})

telescope.load_extension("fzf")

keybind.set("n", "<leader>O", ":Telescope find_files<CR>", "Telescope: Find Files")
