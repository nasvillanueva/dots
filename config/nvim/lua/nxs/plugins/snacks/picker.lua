local keybind = require("nxs.utils.keybind")

return {
  "folke/snacks.nvim",
  dependencies = { { "folke/trouble.nvim" } },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      picker = {
        enabled = true,
        actions = require("trouble.sources.snacks").actions,
        main = {
          file = false, -- allow non file windows open the selected file
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = 100,
          },
        },
        win = {
          input = {
            keys = {
              ["<C-t>"] = { "trouble_open", mode = { "n", "i" } },
              -- Disable conflicting keybinds for bsuth/emacs-binding.nvim by keeping them for
              -- input mode or disabling.
              ["<C-a>"] = { "select_all", mode = "n" },
              ["<C-b>"] = { "preview_scroll_up", mode = "n" },
              ["<C-f>"] = { "preview_scroll_down", mode = "n" },
              ["<C-d>"] = { "list_scroll_down", mode = "n" },
              ["<C-u>"] = { "list_scroll_up", mode = "n" },
              ["<A-d>"] = { "inspect", mode = "n" },
              ["<C-k>"] = false,
              ["<C-n>"] = false,
              ["<A-f>"] = false,
            },
          },
        },
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    })
  end,
  keys = {
    keybind.lazyKey("", "<leader><space>", function()
      require("snacks").picker.smart({
        filter = {
          paths = {
            -- Need to add cwd as filter.path because `smart` picker includes
            -- vim.v.oldfiles which may contain files outside the cwd
            [vim.fn.getcwd()] = true,
            [vim.fn.getcwd() .. "/.git"] = false,
          },
        },
      })
    end, "Picker: Smart Find Files"),
    keybind.lazyKey("", "<leader>,", function()
      require("snacks").picker.buffers()
    end, "Picker: Buffers"),
    keybind.lazyKey("", "<leader>/", function()
      require("snacks").picker.grep()
    end, "Picker: Grep"),
    keybind.lazyKey("", "<leader>.", function()
      local path = vim.fn.expand("%:p:h")
      if vim.bo.filetype == "oil" then
        path = string.sub(path, 5)
      end
      require("snacks").picker.grep({ cwd = path })
    end, "Picker: Grep CWD"),

    keybind.lazyKey("", "<leader>:", function()
      require("snacks").picker.command_history()
    end, "Picker: Command History"),
    keybind.lazyKey("", "<leader>n", function()
      require("snacks").picker.notifications()
    end, "Picker: Notification History"),
    -- find
    keybind.lazyKey("", "<leader>fb", function()
      require("snacks").picker.buffers()
    end, "Picker: Buffers"),
    keybind.lazyKey("", "<leader>fc", function()
      ---@diagnostic disable-next-line: assign-type-mismatch
      require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
    end, "Picker: Find Config File"),
    keybind.lazyKey("", "<leader>ff", function()
      require("snacks").picker.files()
    end, "Picker: Find Files"),
    keybind.lazyKey("", "<leader>fg", function()
      require("snacks").picker.git_files()
    end, "Picker: Find Git Files"),
    keybind.lazyKey("", "<leader>fp", function()
      require("snacks").picker.projects()
    end, "Picker: Projects"),
    keybind.lazyKey("", "<leader>fr", function()
      require("snacks").picker.recent({
        filter = {
          paths = {
            -- Need to add cwd as filter.path because `smart` picker includes
            -- vim.v.oldfiles which may contain files outside the cwd
            [vim.fn.getcwd()] = true,
            [vim.fn.getcwd() .. "/.git"] = false,
          },
        },
      })
    end, "Picker: Recent"),
    -- git
    keybind.lazyKey("", "<leader>gb", function()
      require("snacks").picker.git_branches()
    end, "Picker: Git Branches"),
    keybind.lazyKey("", "<leader>gl", function()
      require("snacks").picker.git_log()
    end, "Picker: Git Log"),
    keybind.lazyKey("", "<leader>gL", function()
      require("snacks").picker.git_log_line()
    end, "Picker: Git Log Line"),
    keybind.lazyKey("", "<leader>gs", function()
      require("snacks").picker.git_status()
    end, "Picker: Git Status"),
    keybind.lazyKey("", "<leader>gS", function()
      require("snacks").picker.git_stash()
    end, "Picker: Git Stash"),
    keybind.lazyKey("", "<leader>gd", function()
      require("snacks").picker.git_diff()
    end, "Picker: Git Diff (Hunks)"),
    keybind.lazyKey("", "<leader>gf", function()
      require("snacks").picker.git_log_file()
    end, "Picker: Git Log File"),
    -- Grep
    keybind.lazyKey("", "<leader>sb", function()
      require("snacks").picker.lines()
    end, "Picker: Buffer Lines"),
    keybind.lazyKey("", "<leader>sB", function()
      require("snacks").picker.grep_buffers()
    end, "Picker: Grep Open Buffers"),
    keybind.lazyKey("", "<leader>sg", function()
      require("snacks").picker.grep()
    end, "Picker: Grep"),
    keybind.lazyKey({ "n", "x" }, "<leader>sw", function()
      require("snacks").picker.grep_word()
    end, "Picker: Visual selection or word"),
    -- search
    keybind.lazyKey("", '<leader>s"', function()
      require("snacks").picker.registers()
    end, "Picker: Registers"),
    keybind.lazyKey("", "<leader>s/", function()
      require("snacks").picker.search_history()
    end, "Picker: Search History"),
    keybind.lazyKey("", "<leader>sa", function()
      require("snacks").picker.autocmds()
    end, "Picker: Autocmds"),
    keybind.lazyKey("", "<leader>sb", function()
      require("snacks").picker.lines()
    end, "Picker: Buffer Lines"),
    keybind.lazyKey("", "<leader>sc", function()
      require("snacks").picker.command_history()
    end, "Picker: Command History"),
    keybind.lazyKey("", "<leader>sC", function()
      require("snacks").picker.commands()
    end, "Picker: Commands"),
    keybind.lazyKey("", "<leader>sd", function()
      require("snacks").picker.diagnostics()
    end, "Picker: Diagnostics"),
    keybind.lazyKey("", "<leader>sD", function()
      require("snacks").picker.diagnostics_buffer()
    end, "Picker: Buffer Diagnostics"),
    keybind.lazyKey("", "<leader>sh", function()
      require("snacks").picker.help()
    end, "Picker: Help Pages"),
    keybind.lazyKey("", "<leader>sH", function()
      require("snacks").picker.highlights()
    end, "Picker: Highlights"),
    keybind.lazyKey("", "<leader>si", function()
      require("snacks").picker.icons()
    end, "Picker: Icons"),
    keybind.lazyKey("", "<leader>sj", function()
      require("snacks").picker.jumps()
    end, "Picker: Jumps"),
    keybind.lazyKey("", "<leader>sk", function()
      require("snacks").picker.keymaps()
    end, "Picker: Keymaps"),
    keybind.lazyKey("", "<leader>sl", function()
      require("snacks").picker.loclist()
    end, "Picker: Location List"),
    keybind.lazyKey("", "<leader>sm", function()
      require("snacks").picker.marks()
    end, "Picker: Marks"),
    keybind.lazyKey("", "<leader>sM", function()
      require("snacks").picker.man()
    end, "Picker: Man Pages"),
    keybind.lazyKey("", "<leader>sp", function()
      require("snacks").picker.lazy()
    end, "Picker: Search for Plugin Spec"),
    keybind.lazyKey("", "<leader>sq", function()
      require("snacks").picker.qflist()
    end, "Picker: Quickfix List"),
    keybind.lazyKey("", "<leader>sR", function()
      require("snacks").picker.resume()
    end, "Picker: Resume"),
    keybind.lazyKey("", "<leader>su", function()
      require("snacks").picker.undo()
    end, "Picker: Undo History"),
    keybind.lazyKey("", "<leader>uC", function()
      require("snacks").picker.colorschemes()
    end, "Picker: Colorschemes"),
  },
}
